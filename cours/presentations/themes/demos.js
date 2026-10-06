(function(){
  function $(id){return document.getElementById(id)}
  function pct(x){return (Math.floor(x*1000+.5)/10).toFixed(1).replace('.',',')+' %'}

  /* ---- A : résolution d'une quête (guerrier niveau 1, force, DD 17, danger 6, 100 XP) ---- */
  var SEUILS=[0,100,300,600,1000];
  function resoudre(jet){
    var total=jet+5+1,crit=jet===20?'RC':jet===1?'EC':'',ok=crit==='RC'?true:crit==='EC'?false:total>=17;
    var perdus=ok?0:(crit==='EC'?12:6),xp=crit==='RC'?150:ok?100:25,niv=1;
    for(var i=0;i<SEUILS.length;i++)if(xp>=SEUILS[i])niv=i+1;
    var apres=Math.max(0,30-perdus),pvMax=30+(niv-1)*10,pv=apres+(apres===0?0:(niv-1)*10);
    return {total:total,crit:crit,ok:ok,perdus:perdus,xp:xp,niv:niv,pv:pv,pvMax:pvMax};
  }
  function renderA(){
    var jet=+$('a-jet').value,r=resoudre(jet);
    $('a-jet-v').textContent=jet;$('a-die').textContent=jet;
    $('a-tot').textContent=jet+' + 5 + 1 = '+r.total+' (DD 17)';
    var o=$('a-out');o.textContent=r.crit==='RC'?'réussite critique':r.crit==='EC'?'échec critique':r.ok?'réussite':'échec';
    o.className='badge '+(r.crit?'crit':r.ok?'ok':'ko');
    $('a-pvt').textContent=r.pv+' / '+r.pvMax;
    var b=$('a-pv');b.style.width=(r.pv/r.pvMax*100)+'%';b.parentNode.classList.toggle('low',r.pv/r.pvMax<.5);
    $('a-xpt').textContent='EXPÉRIENCE +'+r.xp;$('a-lvl').textContent='niveau '+r.niv;
    var lo=SEUILS[r.niv-1],hi=SEUILS[r.niv]||SEUILS[4];
    $('a-xp').style.width=(r.niv>=5?100:Math.min(100,(r.xp-lo)/(hi-lo)*100))+'%';
  }
  $('a-jet').addEventListener('input',renderA);
  $('a-roll').addEventListener('click',function(){
    var d=$('a-die');d.classList.add('roll');setTimeout(function(){d.classList.remove('roll')},520);
    $('a-jet').value=1+Math.floor(Math.random()*20);renderA();
  });
  renderA();

  /* ---- B : TRS (cas d'acceptation n° 2 : 480 min, pause 30, changement de série 15, cycle 60 s) ---- */
  function renderB(){
    var panne=+$('b-panne').value,prod=+$('b-prod').value,reb=Math.min(+$('b-reb').value,prod);
    $('b-panne-v').textContent=panne+' min';$('b-prod-v').textContent=prod;$('b-reb-v').textContent=reb;
    var requis=480-30,marche=requis-panne-15,D,P,Q,note='Quart de 480 min · pause 30 · changement de série 15 · cycle 60 s';
    if(marche<=0){D=0;P=0}else{D=marche/requis;P=Math.min(1,prod/marche);if(prod/marche>1)note='Performance plafonnée à 100 % (drapeau levé) : le temps utile dépasse le temps de marche.'}
    Q=prod>0?(prod-reb)/prod:0;
    var O=D*P*Q;
    $('b-d').textContent=pct(D);$('b-p').textContent=pct(P);$('b-q').textContent=pct(Q);$('b-oee').textContent=pct(O);
    $('b-db').style.width=D*100+'%';$('b-pb').style.width=P*100+'%';$('b-qb').style.width=Q*100+'%';
    $('b-arc').style.strokeDashoffset=502.65*(1-O);$('b-note').textContent=note;
  }
  ['b-panne','b-prod','b-reb'].forEach(function(id){$(id).addEventListener('input',renderB)});
  renderB();

  /* ---- C : répartition (jeu de référence du cas d'acceptation n° 1) ---- */
  var SUJ=[{id:'J1',cap:1,min:1,req:''},{id:'J2',cap:2,min:1,req:''},{id:'J3',cap:1,min:1,req:'robotique'},{id:'J4',cap:2,min:2,req:''}];
  var ETU=[{id:'etu_001',r:1,p:'robotique',v:'J1 · J2 · J3'},{id:'etu_002',r:2,p:'robotique',v:'J1 · J3 · J2'},{id:'etu_003',r:3,p:'vision',v:'J3 · J1 · J4'},{id:'etu_004',r:4,p:'vision',v:'J1 · J3 · J2'},{id:'etu_005',r:5,p:'vision',v:'J2 · J4'}];
  var ACT=[
    {t:'Validation préalable : etu_005 n\'a que 2 vœux, il en faut de 3 à 5. Il n\'est pas traité : voeux_insuffisants.',e:'etu_005',s:'ko',l:'voeux_insuffisants'},
    {t:'etu_001 (rang 1) : J1 est libre. Vœu n° 1.',e:'etu_001',s:'ok',l:'J1 · vœu 1',j:'J1'},
    {t:'etu_002 (rang 2) : J1 est complet. J3 est libre et compatible (robotique). Vœu n° 2.',e:'etu_002',s:'ok',l:'J3 · vœu 2',j:'J3'},
    {t:'etu_003 (rang 3) : J3 est réservé à la robotique, il est ignoré. J1 est complet. J4 est libre. Vœu n° 3.',e:'etu_003',s:'ok',l:'J4 · vœu 3',j:'J4'},
    {t:'etu_004 (rang 4) : J1 est complet, J3 est ignoré (robotique). J2 est libre. Vœu n° 3.',e:'etu_004',s:'ok',l:'J2 · vœu 3',j:'J2'},
    {t:'Bilan : J1, J2 et J3 sont confirmés. J4 est en sous-effectif (1 sur 2). Chacun sait pourquoi.',bilan:1}
  ];
  var step=0;
  function renderC(){
    var st={},occ={J1:0,J2:0,J3:0,J4:0},k;
    for(k=0;k<step;k++){var a=ACT[k];if(a.e)st[a.e]={s:a.s,l:a.l};if(a.j)occ[a.j]++}
    var cur=step>0?ACT[step-1]:null,bilan=cur&&cur.bilan;
    $('c-subs').innerHTML=SUJ.map(function(s){
      var dots='';for(var i=0;i<s.cap;i++)dots+='<i class="'+(i<occ[s.id]?'f':'')+'"></i>';
      var tag=s.req?'<small>'+s.req+'</small>':'<small>ouvert</small>';
      var stt=bilan?'<span class="chip '+(occ[s.id]>=s.min?'n':'v')+'" style="align-self:flex-start">'+(occ[s.id]>=s.min?'confirmé':'sous-effectif')+'</span>':'';
      return '<div class="sub-c"><h4>'+s.id+tag+'</h4><div class="pl">'+dots+'</div>'+stt+'</div>';
    }).join('');
    $('c-stu').innerHTML=ETU.map(function(e){
      var x=st[e.id],c=x?x.s:'',now=cur&&cur.e===e.id?' now':'';
      return '<div class="'+c+now+'"><b>'+e.id+'</b><span>rang '+e.r+' · '+e.p+' · '+e.v+(x?' → <b>'+x.l+'</b>':'')+'</span></div>';
    }).join('');
    $('c-exp').textContent=cur?cur.t:'Cinq étudiants, quatre sujets. Appuyez pour dérouler l\'algorithme.';
    $('c-next').disabled=step>=ACT.length;$('c-next').style.opacity=step>=ACT.length?.4:1;
  }
  $('c-next').addEventListener('click',function(){if(step<ACT.length){step++;renderC()}});
  $('c-reset').addEventListener('click',function(){step=0;renderC()});
  renderC();
})();
