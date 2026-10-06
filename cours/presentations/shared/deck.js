/* Moteur de diaporama partagé.
 * Page attendue : <body data-deck="id" data-notes="notes.html">, des <section class="slide" data-id="…">,
 * des éléments .step (apparitions successives), #prog, #cur, #tot et un <canvas id="bg">.
 * Synchronisation avec la fenêtre de notes : BroadcastChannel « iti-deck:<id> » (voir notes.js). */
(function(){
  var slides=[].slice.call(document.querySelectorAll('.slide'));
  var prog=document.getElementById('prog'),cur=document.getElementById('cur'),tot=document.getElementById('tot');
  var deck=document.body.dataset.deck||'deck',notesUrl=document.body.dataset.notes||'notes.html';
  var i=0,notesWin=null;tot.textContent=slides.length;

  /* ---- synchronisation avec la fenêtre de notes ---- */
  var chan=null;
  try{chan=new BroadcastChannel('iti-deck:'+deck)}catch(e){}
  function state(){
    var st=steps(slides[i]);
    return {t:'state',slide:i,id:slides[i].dataset.id,total:slides.length,on:st.filter(function(e){return e.classList.contains('on')}).length,steps:st.length}
  }
  function emit(){if(chan)chan.postMessage(state())}

  var calm=matchMedia('(prefers-reduced-motion:reduce)').matches;
  var START=calm?0:350,GAP=calm?0:80,FALLBACK=calm?0:900,timer=null,run=0;
  function steps(sl){return [].slice.call(sl.querySelectorAll('.step'))}
  function pending(sl){return steps(sl).filter(function(e){return !e.classList.contains('on')})}
  function stop(){run++;clearTimeout(timer)}
  /* chaque étape démarre quand l'animation de la précédente se termine */
  function reveal(sl){
    stop();var me=run,list=pending(sl),k=0;
    function go(){
      if(me!==run||k>=list.length)return;
      var el=list[k++],done=false;
      function fin(){
        if(done)return;done=true;el.removeEventListener('transitionend',onEnd);clearTimeout(timer);
        if(me===run)timer=setTimeout(go,GAP);
      }
      function onEnd(e){if(e.target===el&&e.propertyName==='opacity')fin()}
      el.addEventListener('transitionend',onEnd);
      timer=setTimeout(fin,FALLBACK);
      el.classList.add('on');emit();
    }
    timer=setTimeout(go,START);
  }
  function show(n,all){
    n=Math.max(0,Math.min(slides.length-1,n));i=n;stop();
    slides.forEach(function(s,k){s.classList.toggle('active',k===n);s.classList.toggle('past',k<n);if(k>n)steps(s).forEach(function(e){e.classList.remove('on')})});
    steps(slides[n]).forEach(function(e){e.classList.toggle('on',!!all)});
    if(!all)reveal(slides[n]);
    prog.style.width=((n+1)/slides.length*100)+'%';cur.textContent=n+1;
    try{history.replaceState(null,'','#'+(n+1))}catch(e){}
    emit();
  }
  /* suivant : termine d'abord l'apparition en cours, sinon passe à la slide suivante */
  function next(){var p=pending(slides[i]);if(p.length){stop();p.forEach(function(e){e.classList.add('on')});emit();return}if(i<slides.length-1)show(i+1,false)}
  function prev(){if(i>0)show(i-1,true)}
  function overview(){document.body.classList.toggle('overview');if(!document.body.classList.contains('overview'))show(i,true)}
  function openNotes(){
    /* « popup » : le navigateur ouvre une fenêtre à part, pas un onglet */
    notesWin=window.open(notesUrl,'iti-notes-'+deck,'popup=yes,width='+Math.round(screen.availWidth*.5)+',height='+Math.round(screen.availHeight*.9)+',left=0,top=0');
    if(notesWin)notesWin.focus();
  }
  if(chan)chan.onmessage=function(e){
    var m=e.data||{};
    if(m.t==='hello')emit();
    else if(m.t==='cmd'){
      if(m.c==='next')next();else if(m.c==='prev')prev();
      else if(m.c==='goto'&&typeof m.n==='number')show(m.n,m.n<i);
      else if(m.c==='first')show(0,false);else if(m.c==='last')show(slides.length-1,true);
    }
  };
  document.addEventListener('keydown',function(e){
    if(e.metaKey||e.ctrlKey||e.altKey)return;var k=e.key;if(e.target&&/^(INPUT|BUTTON)$/.test(e.target.tagName)&&(k===' '||k==='Enter'||k.indexOf('Arrow')===0))return;
    if(k==='ArrowRight'||k==='PageDown'||k===' '||k==='Enter'){e.preventDefault();next()}
    else if(k==='ArrowLeft'||k==='PageUp'||k==='Backspace'){e.preventDefault();prev()}
    else if(k==='Home')show(0,false);else if(k==='End')show(slides.length-1,true);
    else if(k==='f'||k==='F'){document.fullscreenElement?document.exitFullscreen():document.documentElement.requestFullscreen&&document.documentElement.requestFullscreen()}
    else if(k==='n'||k==='N')openNotes();
    else if(k==='o'||k==='O'||(k==='Escape'&&document.body.classList.contains('overview')))overview();
  });
  slides.forEach(function(s,k){s.addEventListener('click',function(e){if(document.body.classList.contains('overview')){e.stopPropagation();i=k;overview()}})});
  var tx=null;
  document.addEventListener('touchstart',function(e){tx=(e.target.closest&&e.target.closest('[data-ui]'))?null:e.touches[0].clientX},{passive:true});
  document.addEventListener('touchend',function(e){if(tx===null)return;var d=e.changedTouches[0].clientX-tx;if(Math.abs(d)>60){d<0?next():prev()}tx=null});
  document.addEventListener('click',function(e){if(document.body.classList.contains('overview'))return;if(e.target.closest&&e.target.closest('[data-ui]'))return;e.clientX>innerWidth*0.3?next():prev()});
  window.addEventListener('beforeprint',function(){stop();slides.forEach(function(s){steps(s).forEach(function(e){e.classList.add('on')})})});
  var h=parseInt((location.hash||'').slice(1),10);show(isNaN(h)?0:h-1,false);

  /* fond : réseau de nœuds */
  var cv=document.getElementById('bg'),cx=cv.getContext('2d'),pts=[],W=0,H=0;
  var cols=['67,56,245','123,63,242','0,168,198'];
  function size(){var dpr=Math.min(2,devicePixelRatio||1);W=cv.clientWidth;H=cv.clientHeight;cv.width=W*dpr;cv.height=H*dpr;cx.setTransform(dpr,0,0,dpr,0,0);
    var n=Math.round(W*H/26000);pts=[];for(var k=0;k<n;k++)pts.push({x:Math.random()*W,y:Math.random()*H,vx:(Math.random()-.5)*.25,vy:(Math.random()-.5)*.25,c:k%3})}
  function draw(){
    cx.clearRect(0,0,W,H);var L=Math.min(W,H)*.17;
    for(var a=0;a<pts.length;a++){var p=pts[a];p.x+=p.vx;p.y+=p.vy;if(p.x<0||p.x>W)p.vx*=-1;if(p.y<0||p.y>H)p.vy*=-1;
      for(var b=a+1;b<pts.length;b++){var q=pts[b],dx=p.x-q.x,dy=p.y-q.y,d=Math.sqrt(dx*dx+dy*dy);if(d<L){cx.strokeStyle='rgba('+cols[p.c]+','+(.2*(1-d/L))+')';cx.lineWidth=1;cx.beginPath();cx.moveTo(p.x,p.y);cx.lineTo(q.x,q.y);cx.stroke()}}
      cx.fillStyle='rgba('+cols[p.c]+',.35)';cx.beginPath();cx.arc(p.x,p.y,2.2,0,6.283);cx.fill()}
  }
  function loop(){if(!document.body.classList.contains('overview'))draw();requestAnimationFrame(loop)}
  size();window.addEventListener('resize',size);
  if(calm)draw();else loop();
})();
