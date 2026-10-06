/* Vue présentateur : suit le diaporama (BroadcastChannel « iti-deck:<id> »), met en avant les notes
 * de la slide courante et permet de piloter le diaporama. Les sections <section class="s" id="data-id">
 * du <main> portent les notes ; la navigation latérale est construite à partir d'elles. */
(function(){
  var deck=document.body.dataset.deck||'deck';
  var main=document.querySelector('main'),nav=document.querySelector('nav');
  var secs=[].slice.call(main.querySelectorAll('section.s'));

  /* navigation : parties + titres de sections */
  var n=0;
  [].slice.call(main.children).forEach(function(el){
    if(el.classList.contains('part-h')){var p=document.createElement('div');p.className='part';p.textContent=el.textContent;nav.appendChild(p)}
    else if(el.matches('section.s')){
      n++;var a=document.createElement('a');a.href='#'+el.id;a.dataset.n=n-1;
      a.innerHTML='<b>'+n+'</b>';a.appendChild(document.createTextNode(el.querySelector('h2').textContent));
      a.addEventListener('click',function(e){e.preventDefault();send({t:'cmd',c:'goto',n:+a.dataset.n})});nav.appendChild(a);
    }
  });
  var links=[].slice.call(nav.querySelectorAll('a'));

  /* durées prévues (« 1,5 min ») cumulées */
  var mins=secs.map(function(s){var t=s.querySelector('.t');var m=t&&t.textContent.match(/[\d,.]+/);return m?parseFloat(m[0].replace(',','.')):0});
  var cum=[],acc=0;mins.forEach(function(m){acc+=m;cum.push(acc)});

  /* barre de contrôle */
  var bar=document.createElement('div');bar.id='bar';
  bar.innerHTML='<button data-c="prev" title="Précédent (←)">←</button><button class="go" data-c="next" title="Suivant (→ ou espace)">→</button>'
    +'<div class="pos"><span id="p-n">–</span><small id="p-s"></small></div><div class="next" id="p-next"></div>'
    +'<div class="clock" id="p-clock" title="Cliquer pour remettre à zéro"></div>'
    +'<button id="p-focus" title="Afficher seulement les notes de la slide courante (F)">Focus</button>'
    +'<div class="link" id="p-link"><i></i><span>hors ligne</span></div>';
  document.body.insertBefore(bar,document.body.firstChild);
  var $=function(id){return document.getElementById(id)};

  var chan=null;try{chan=new BroadcastChannel('iti-deck:'+deck)}catch(e){}
  function send(m){if(chan)chan.postMessage(m)}
  bar.addEventListener('click',function(e){var b=e.target.closest('button[data-c]');if(b){send({t:'cmd',c:b.dataset.c});b.blur()}});

  var focus=false;try{focus=localStorage.getItem('iti-focus')==='1'}catch(e){}
  function setFocus(v){focus=v;document.body.classList.toggle('focus',v);$('p-focus').classList.toggle('on',v);try{localStorage.setItem('iti-focus',v?'1':'0')}catch(e){}}
  $('p-focus').addEventListener('click',function(){setFocus(!focus);if(cur>=0)scrollTo(cur,true)});
  setFocus(focus);

  /* chronomètre : démarre à la première synchronisation */
  var t0=null,cur=-1,lastSeen=0;
  function fmt(s){s=Math.max(0,Math.round(s));return Math.floor(s/60)+':'+('0'+s%60).slice(-2)}
  $('p-clock').addEventListener('click',function(){t0=performance.now()});
  function tick(){
    if(t0===null){$('p-clock').textContent='';return}
    var el=(performance.now()-t0)/1000,txt='écoulé '+fmt(el);
    var late=false;
    if(cur>=0){var plan=cum[cur-1]||0;txt+='<br>prévu '+fmt(plan*60)+' / '+fmt(acc*60);late=el/60>(cum[cur]||acc)+1}
    $('p-clock').innerHTML=txt;$('p-clock').classList.toggle('late',late);
    $('p-link').classList.toggle('ok',lastSeen>0);
    $('p-link').lastChild.textContent=lastSeen>0?'synchronisé':'hors ligne';
  }
  setInterval(tick,1000);

  function scrollTo(k,instant){
    var el=secs[k];if(!el)return;
    el.scrollIntoView({behavior:instant?'auto':'smooth',block:'start'});
  }
  function apply(m){
    if(t0===null)t0=performance.now();
    lastSeen=performance.now();
    var k=-1;for(var j=0;j<secs.length;j++)if(secs[j].id===m.id){k=j;break}
    $('p-n').textContent=(m.slide+1)+' / '+m.total;
    $('p-s').textContent=m.steps?('étape '+m.on+'/'+m.steps):'';
    if(k<0){$('p-next').textContent='Pas de notes pour « '+m.id+' »';return}
    var changed=k!==cur;cur=k;
    secs.forEach(function(s,j){s.classList.toggle('current',j===k)});
    links.forEach(function(a,j){a.classList.toggle('cur',j===k)});
    var nx=secs[k+1];
    $('p-next').innerHTML=nx?'<b>Ensuite</b> · '+nx.querySelector('h2').textContent:'<b>Dernière slide</b>';
    if(changed){scrollTo(k);var a=links[k];if(a&&a.scrollIntoView)a.scrollIntoView({block:'nearest'});tick()}
  }
  if(chan)chan.onmessage=function(e){var m=e.data||{};if(m.t==='state')apply(m)};
  send({t:'hello'});
  /* le diaporama peut s'ouvrir après les notes : on redemande jusqu'à obtenir une réponse */
  var retry=setInterval(function(){if(lastSeen>0)clearInterval(retry);else send({t:'hello'})},1500);

  document.addEventListener('keydown',function(e){
    if(e.metaKey||e.ctrlKey||e.altKey)return;var k=e.key;
    if(k==='ArrowRight'||k==='PageDown'||k===' '||k==='Enter'){e.preventDefault();send({t:'cmd',c:'next'})}
    else if(k==='ArrowLeft'||k==='PageUp'||k==='Backspace'){e.preventDefault();send({t:'cmd',c:'prev'})}
    else if(k==='Home'){e.preventDefault();send({t:'cmd',c:'first'})}
    else if(k==='End'){e.preventDefault();send({t:'cmd',c:'last'})}
    else if(k==='f'||k==='F'){setFocus(!focus);if(cur>=0)scrollTo(cur,true)}
  });
})();
