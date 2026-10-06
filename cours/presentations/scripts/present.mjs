#!/usr/bin/env node
/* Lance une présentation : serveur local, diaporama dans une fenêtre, notes dans une autre.
 * Usage : node scripts/present.mjs <deck> [--no-open] [--no-notes] [--port 4173] [--browser chrome|firefox|…]
 * Les deux pages se synchronisent via BroadcastChannel, elles doivent donc être dans le même profil de navigateur. */
import http from 'node:http'
import fs from 'node:fs'
import path from 'node:path'
import os from 'node:os'
import { spawn, spawnSync } from 'node:child_process'
import { fileURLToPath } from 'node:url'

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..')
const TYPES = {
  '.html': 'text/html; charset=utf-8', '.css': 'text/css; charset=utf-8', '.js': 'text/javascript; charset=utf-8',
  '.json': 'application/json; charset=utf-8', '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml', '.webp': 'image/webp', '.gif': 'image/gif', '.woff2': 'font/woff2', '.ico': 'image/x-icon',
}

const decks = fs.readdirSync(ROOT, { withFileTypes: true })
  .filter(d => d.isDirectory() && fs.existsSync(path.join(ROOT, d.name, 'index.html')) && fs.existsSync(path.join(ROOT, d.name, 'notes.html')))
  .map(d => d.name)

const argv = process.argv.slice(2)
const flag = name => argv.includes(`--${name}`)
const opt = name => { const k = argv.indexOf(`--${name}`); return k >= 0 ? argv[k + 1] : undefined }
const deck = argv.find((a, k) => !a.startsWith('--') && !(k > 0 && ['--port', '--browser'].includes(argv[k - 1])))

if (!deck || !decks.includes(deck)) {
  console.error(`Présentation inconnue${deck ? ` : « ${deck} »` : ''}. Disponibles : ${decks.join(', ')}`)
  process.exit(1)
}

const server = http.createServer((req, res) => {
  let p
  try { p = decodeURIComponent(new URL(req.url, 'http://x').pathname) } catch { res.writeHead(400).end(); return }
  if (p.endsWith('/')) p += 'index.html'
  const file = path.join(ROOT, p)
  if (file !== ROOT && !file.startsWith(ROOT + path.sep)) { res.writeHead(403).end(); return }
  fs.stat(file, (err, st) => {
    if (err || !st.isFile()) { res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' }).end('Introuvable'); return }
    res.writeHead(200, { 'Content-Type': TYPES[path.extname(file)] || 'application/octet-stream', 'Cache-Control': 'no-store' })
    fs.createReadStream(file).pipe(res)
  })
})

function listen(port, tries = 20) {
  return new Promise((resolve, reject) => {
    const onError = e => (e.code === 'EADDRINUSE' && tries > 0) ? resolve(listen(port + 1, tries - 1)) : reject(e)
    server.once('error', onError)
    server.listen(port, '127.0.0.1', () => { server.off('error', onError); resolve(port) })
  })
}

/* ---- ouverture des fenêtres ---- */
const has = cmd => spawnSync(process.platform === 'win32' ? 'where' : 'which', [cmd], { stdio: 'ignore' }).status === 0
const LINUX = ['google-chrome', 'google-chrome-stable', 'chromium', 'chromium-browser', 'brave-browser', 'microsoft-edge', 'firefox']
const MAC = { chrome: 'Google Chrome', chromium: 'Chromium', brave: 'Brave Browser', edge: 'Microsoft Edge', firefox: 'Firefox' }

function opener(wanted) {
  const w = (wanted || process.env.BROWSER || '').toLowerCase()
  if (process.platform === 'darwin') {
    const app = MAC[w] || wanted || 'Google Chrome'
    return url => spawn('open', ['-na', app, '--args', '--new-window', url], { detached: true, stdio: 'ignore' })
  }
  if (process.platform === 'win32') {
    const exe = { chrome: 'chrome', firefox: 'firefox', edge: 'msedge' }[w] || wanted || 'chrome'
    return url => spawn('cmd', ['/c', 'start', '', exe, '--new-window', url], { detached: true, stdio: 'ignore' })
  }
  const bin = (w && has(w) && w) || LINUX.find(b => (!w || b.includes(w)) && has(b)) || LINUX.find(has)
  if (!bin) return null
  return url => spawn(bin, ['--new-window', url], { detached: true, stdio: 'ignore' })
}

const wait = ms => new Promise(r => setTimeout(r, ms))
const port = await listen(Number(opt('port') || process.env.PORT || 4173))
const base = `http://127.0.0.1:${port}/${deck}/`
const slidesUrl = base, notesUrl = `${base}notes.html`
console.log(`\n  ${deck}\n  diaporama : ${slidesUrl}\n  notes     : ${notesUrl}\n`)

if (!flag('no-open')) {
  const open = opener(opt('browser'))
  if (!open) {
    console.log('  Aucun navigateur trouvé : ouvrez les deux adresses ci-dessus dans deux fenêtres du même navigateur.')
  } else {
    open(slidesUrl).unref()
    if (!flag('no-notes')) { await wait(1200); open(notesUrl).unref() }
    console.log('  Deux fenêtres ont été ouvertes (même navigateur, même profil). Déplacez le diaporama sur le projecteur, F pour le plein écran.')
  }
}
console.log('  Ctrl+C pour arrêter le serveur.\n')
process.on('SIGINT', () => { server.close(); process.exit(0) })
