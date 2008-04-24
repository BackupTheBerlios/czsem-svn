%%%%%%%%%%%%%%%%%%%%%%%
% Declarations
%:- set(nodes,500000)?
%:- set(h,1000000)?
%:- set(r,10000)?
:- set(c,2),set(i,2),  set(inflate,800)?
:- set(verbose,2)?
:- modeh(1,tree_root(+node))?
:- modeb(*,edge(-node,+node))?
:- modeb(*,edge(+node,-node))?
:- modeb(*,edge(+node,+node))?

:- modeb(1,m_tag0(+node,#const))?
:- modeb(1,m_tag1(+node,#const))?
:- modeb(1,m_tag2(+node,#const))?
:- modeb(1,m_tag3(+node,#const))?
:- modeb(1,m_tag4(+node,#const))?
:- modeb(1,m_tag5(+node,#const))?
:- modeb(1,m_tag6(+node,#const))?
:- modeb(1,m_tag7(+node,#const))?
:- modeb(1,m_tag8(+node,#const))?
:- modeb(1,m_tag9(+node,#const))?
:- modeb(1,m_tag10(+node,#const))?
:- modeb(1,m_tag11(+node,#const))?
:- modeb(1,m_tag12(+node,#const))?
:- modeb(1,m_tag13(+node,#const))?
:- modeb(1,m_tag14(+node,#const))?

% begin of definitions of linguistic attributes
:- modeb(1,functor(+node,#const))?
:- modeb(1,gram_sempos(+node,#const))?
:- modeb(1,id(+node,#const))?
:- modeb(1,t_lemma(+node,#const))?
:- modeb(1,a_afun(+node,#const))?
:- modeb(1,m_form(+node,#const))?
:- modeb(1,m_lemma(+node,#const))?
:- modeb(1,m_tag(+node,#const))?
% end of definitions of linguistic attributes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ve zdemolovanem trabantu na miste zemreli dva muzi - 82lety senior a dalsi muz, jehoz totoznost zjistuji policiste. 
tree_root(node0_0).
%%%%%%%% node0_0 %%%%%%%%%%%%%%%%%%%
node(node0_0).
id(node0_0, t_jihomoravsky49640_txt_001_p1s4).         const(t_jihomoravsky49640_txt_001_p1s4).
%%%%%%%% node0_1 %%%%%%%%%%%%%%%%%%%
node(node0_1).
functor(node0_1, pred).         const(pred).
gram_sempos(node0_1, v).         const(v).
id(node0_1, t_jihomoravsky49640_txt_001_p1s4a1).         const(t_jihomoravsky49640_txt_001_p1s4a1).
t_lemma(node0_1, zemrit).         const(zemrit).
%%%%%%%% node0_2 %%%%%%%%%%%%%%%%%%%
node(node0_2).
functor(node0_2, act).         const(act).
gram_sempos(node0_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node0_2, t_jihomoravsky49640_txt_001_p1s4a20).         const(t_jihomoravsky49640_txt_001_p1s4a20).
t_lemma(node0_2, x_perspron).         const(x_perspron).
%%%%%%%% node0_3 %%%%%%%%%%%%%%%%%%%
node(node0_3).
functor(node0_3, loc).         const(loc).
gram_sempos(node0_3, n_denot).         const(n_denot).
id(node0_3, t_jihomoravsky49640_txt_001_p1s4a3).         const(t_jihomoravsky49640_txt_001_p1s4a3).
t_lemma(node0_3, trabant).         const(trabant).
%%%%%%%% node0_4 %%%%%%%%%%%%%%%%%%%
node(node0_4).
functor(node0_4, rstr).         const(rstr).
gram_sempos(node0_4, adj_denot).         const(adj_denot).
id(node0_4, t_jihomoravsky49640_txt_001_p1s4a4).         const(t_jihomoravsky49640_txt_001_p1s4a4).
t_lemma(node0_4, zdemolovany).         const(zdemolovany).
%%%%%%%% node0_5 %%%%%%%%%%%%%%%%%%%
node(node0_5).
a_afun(node0_5, atr).         const(atr).
m_form(node0_5, zdemolovanem).         const(zdemolovanem).
m_lemma(node0_5, zdemolovany____2t_).         const(zdemolovany____2t_).
m_tag(node0_5, aais6____1a____).         const(aais6____1a____).
m_tag0(node0_5,'a'). const('a'). m_tag1(node0_5,'a'). const('a'). m_tag2(node0_5,'i'). const('i'). m_tag3(node0_5,'s'). const('s'). m_tag4(node0_5,'6'). const('6'). m_tag9(node0_5,'1'). const('1'). m_tag10(node0_5,'a'). const('a'). 
%%%%%%%% node0_6 %%%%%%%%%%%%%%%%%%%
node(node0_6).
a_afun(node0_6, auxp).         const(auxp).
m_form(node0_6, ve).         const(ve).
m_lemma(node0_6, v_1).         const(v_1).
m_tag(node0_6, rv__6__________).         const(rv__6__________).
m_tag0(node0_6,'r'). const('r'). m_tag1(node0_6,'v'). const('v'). m_tag4(node0_6,'6'). const('6'). 
%%%%%%%% node0_7 %%%%%%%%%%%%%%%%%%%
node(node0_7).
a_afun(node0_7, adv).         const(adv).
m_form(node0_7, trabantu).         const(trabantu).
m_lemma(node0_7, trabant_2__r___vozidlo_).         const(trabant_2__r___vozidlo_).
m_tag(node0_7, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node0_7,'n'). const('n'). m_tag1(node0_7,'n'). const('n'). m_tag2(node0_7,'i'). const('i'). m_tag3(node0_7,'s'). const('s'). m_tag4(node0_7,'6'). const('6'). m_tag10(node0_7,'a'). const('a'). 
%%%%%%%% node0_8 %%%%%%%%%%%%%%%%%%%
node(node0_8).
functor(node0_8, loc).         const(loc).
gram_sempos(node0_8, n_denot).         const(n_denot).
id(node0_8, t_jihomoravsky49640_txt_001_p1s4a6).         const(t_jihomoravsky49640_txt_001_p1s4a6).
t_lemma(node0_8, misto).         const(misto).
%%%%%%%% node0_9 %%%%%%%%%%%%%%%%%%%
node(node0_9).
a_afun(node0_9, auxp).         const(auxp).
m_form(node0_9, na).         const(na).
m_lemma(node0_9, na_1).         const(na_1).
m_tag(node0_9, rr__6__________).         const(rr__6__________).
m_tag0(node0_9,'r'). const('r'). m_tag1(node0_9,'r'). const('r'). m_tag4(node0_9,'6'). const('6'). 
%%%%%%%% node0_10 %%%%%%%%%%%%%%%%%%%
node(node0_10).
a_afun(node0_10, atr).         const(atr).
m_form(node0_10, miste).         const(miste).
m_lemma(node0_10, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node0_10, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node0_10,'n'). const('n'). m_tag1(node0_10,'n'). const('n'). m_tag2(node0_10,'n'). const('n'). m_tag3(node0_10,'s'). const('s'). m_tag4(node0_10,'6'). const('6'). m_tag10(node0_10,'a'). const('a'). 
%%%%%%%% node0_11 %%%%%%%%%%%%%%%%%%%
node(node0_11).
a_afun(node0_11, pred).         const(pred).
m_form(node0_11, zemreli).         const(zemreli).
m_lemma(node0_11, zemrit).         const(zemrit).
m_tag(node0_11, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node0_11,'v'). const('v'). m_tag1(node0_11,'p'). const('p'). m_tag2(node0_11,'m'). const('m'). m_tag3(node0_11,'p'). const('p'). m_tag7(node0_11,'x'). const('x'). m_tag8(node0_11,'r'). const('r'). m_tag10(node0_11,'a'). const('a'). m_tag11(node0_11,'a'). const('a'). 
%%%%%%%% node0_12 %%%%%%%%%%%%%%%%%%%
node(node0_12).
functor(node0_12, apps).         const(apps).
id(node0_12, t_jihomoravsky49640_txt_001_p1s4a7).         const(t_jihomoravsky49640_txt_001_p1s4a7).
t_lemma(node0_12, x_dash).         const(x_dash).
%%%%%%%% node0_13 %%%%%%%%%%%%%%%%%%%
node(node0_13).
functor(node0_13, act).         const(act).
gram_sempos(node0_13, n_denot).         const(n_denot).
id(node0_13, t_jihomoravsky49640_txt_001_p1s4a8).         const(t_jihomoravsky49640_txt_001_p1s4a8).
t_lemma(node0_13, muz).         const(muz).
%%%%%%%% node0_14 %%%%%%%%%%%%%%%%%%%
node(node0_14).
functor(node0_14, rstr).         const(rstr).
gram_sempos(node0_14, adj_quant_def).         const(adj_quant_def).
id(node0_14, t_jihomoravsky49640_txt_001_p1s4a9).         const(t_jihomoravsky49640_txt_001_p1s4a9).
t_lemma(node0_14, dva).         const(dva).
%%%%%%%% node0_15 %%%%%%%%%%%%%%%%%%%
node(node0_15).
a_afun(node0_15, atr).         const(atr).
m_form(node0_15, dva).         const(dva).
m_lemma(node0_15, dva_2).         const(dva_2).
m_tag(node0_15, clyp1__________).         const(clyp1__________).
m_tag0(node0_15,'c'). const('c'). m_tag1(node0_15,'l'). const('l'). m_tag2(node0_15,'y'). const('y'). m_tag3(node0_15,'p'). const('p'). m_tag4(node0_15,'1'). const('1'). 
%%%%%%%% node0_16 %%%%%%%%%%%%%%%%%%%
node(node0_16).
a_afun(node0_16, sb).         const(sb).
m_form(node0_16, muzi).         const(muzi).
m_lemma(node0_16, muz).         const(muz).
m_tag(node0_16, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node0_16,'n'). const('n'). m_tag1(node0_16,'n'). const('n'). m_tag2(node0_16,'m'). const('m'). m_tag3(node0_16,'p'). const('p'). m_tag4(node0_16,'1'). const('1'). m_tag10(node0_16,'a'). const('a'). 
%%%%%%%% node0_17 %%%%%%%%%%%%%%%%%%%
node(node0_17).
a_afun(node0_17, apos).         const(apos).
m_form(node0_17, x_).         const(x_).
m_lemma(node0_17, x_).         const(x_).
m_tag(node0_17, z______________).         const(z______________).
m_tag0(node0_17,'z'). const('z'). m_tag1(node0_17,':'). const(':'). 
%%%%%%%% node0_18 %%%%%%%%%%%%%%%%%%%
node(node0_18).
functor(node0_18, conj).         const(conj).
id(node0_18, t_jihomoravsky49640_txt_001_p1s4a10).         const(t_jihomoravsky49640_txt_001_p1s4a10).
t_lemma(node0_18, a).         const(a).
%%%%%%%% node0_19 %%%%%%%%%%%%%%%%%%%
node(node0_19).
functor(node0_19, denom).         const(denom).
gram_sempos(node0_19, n_denot).         const(n_denot).
id(node0_19, t_jihomoravsky49640_txt_001_p1s4a11).         const(t_jihomoravsky49640_txt_001_p1s4a11).
t_lemma(node0_19, senior).         const(senior).
%%%%%%%% node0_20 %%%%%%%%%%%%%%%%%%%
node(node0_20).
functor(node0_20, rstr).         const(rstr).
gram_sempos(node0_20, adj_denot).         const(adj_denot).
id(node0_20, t_jihomoravsky49640_txt_001_p1s4a12).         const(t_jihomoravsky49640_txt_001_p1s4a12).
t_lemma(node0_20, x82lety).         const(x82lety).
%%%%%%%% node0_21 %%%%%%%%%%%%%%%%%%%
node(node0_21).
a_afun(node0_21, atr).         const(atr).
m_form(node0_21, x82lety).         const(x82lety).
m_lemma(node0_21, x82lety).         const(x82lety).
m_tag(node0_21, aams1____1a____).         const(aams1____1a____).
m_tag0(node0_21,'a'). const('a'). m_tag1(node0_21,'a'). const('a'). m_tag2(node0_21,'m'). const('m'). m_tag3(node0_21,'s'). const('s'). m_tag4(node0_21,'1'). const('1'). m_tag9(node0_21,'1'). const('1'). m_tag10(node0_21,'a'). const('a'). 
%%%%%%%% node0_22 %%%%%%%%%%%%%%%%%%%
node(node0_22).
a_afun(node0_22, sb).         const(sb).
m_form(node0_22, senior).         const(senior).
m_lemma(node0_22, senior).         const(senior).
m_tag(node0_22, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node0_22,'n'). const('n'). m_tag1(node0_22,'n'). const('n'). m_tag2(node0_22,'m'). const('m'). m_tag3(node0_22,'s'). const('s'). m_tag4(node0_22,'1'). const('1'). m_tag10(node0_22,'a'). const('a'). 
%%%%%%%% node0_23 %%%%%%%%%%%%%%%%%%%
node(node0_23).
a_afun(node0_23, coord).         const(coord).
m_form(node0_23, a).         const(a).
m_lemma(node0_23, a_1).         const(a_1).
m_tag(node0_23, j______________).         const(j______________).
m_tag0(node0_23,'j'). const('j'). m_tag1(node0_23,'^'). const('^'). 
%%%%%%%% node0_24 %%%%%%%%%%%%%%%%%%%
node(node0_24).
functor(node0_24, denom).         const(denom).
gram_sempos(node0_24, n_denot).         const(n_denot).
id(node0_24, t_jihomoravsky49640_txt_001_p1s4a13).         const(t_jihomoravsky49640_txt_001_p1s4a13).
t_lemma(node0_24, muz).         const(muz).
%%%%%%%% node0_25 %%%%%%%%%%%%%%%%%%%
node(node0_25).
functor(node0_25, rstr).         const(rstr).
gram_sempos(node0_25, adj_denot).         const(adj_denot).
id(node0_25, t_jihomoravsky49640_txt_001_p1s4a14).         const(t_jihomoravsky49640_txt_001_p1s4a14).
t_lemma(node0_25, dalsi).         const(dalsi).
%%%%%%%% node0_26 %%%%%%%%%%%%%%%%%%%
node(node0_26).
a_afun(node0_26, atr).         const(atr).
m_form(node0_26, dalsi).         const(dalsi).
m_lemma(node0_26, dalsi).         const(dalsi).
m_tag(node0_26, aams1____1a____).         const(aams1____1a____).
m_tag0(node0_26,'a'). const('a'). m_tag1(node0_26,'a'). const('a'). m_tag2(node0_26,'m'). const('m'). m_tag3(node0_26,'s'). const('s'). m_tag4(node0_26,'1'). const('1'). m_tag9(node0_26,'1'). const('1'). m_tag10(node0_26,'a'). const('a'). 
%%%%%%%% node0_27 %%%%%%%%%%%%%%%%%%%
node(node0_27).
a_afun(node0_27, sb).         const(sb).
m_form(node0_27, muz).         const(muz).
m_lemma(node0_27, muz).         const(muz).
m_tag(node0_27, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node0_27,'n'). const('n'). m_tag1(node0_27,'n'). const('n'). m_tag2(node0_27,'m'). const('m'). m_tag3(node0_27,'s'). const('s'). m_tag4(node0_27,'1'). const('1'). m_tag10(node0_27,'a'). const('a'). 
%%%%%%%% node0_28 %%%%%%%%%%%%%%%%%%%
node(node0_28).
functor(node0_28, rstr).         const(rstr).
gram_sempos(node0_28, v).         const(v).
id(node0_28, t_jihomoravsky49640_txt_001_p1s4a15).         const(t_jihomoravsky49640_txt_001_p1s4a15).
t_lemma(node0_28, zjistovat).         const(zjistovat).
%%%%%%%% node0_29 %%%%%%%%%%%%%%%%%%%
node(node0_29).
functor(node0_29, act).         const(act).
gram_sempos(node0_29, n_denot_neg).         const(n_denot_neg).
id(node0_29, t_jihomoravsky49640_txt_001_p1s4a17).         const(t_jihomoravsky49640_txt_001_p1s4a17).
t_lemma(node0_29, totoznost).         const(totoznost).
%%%%%%%% node0_30 %%%%%%%%%%%%%%%%%%%
node(node0_30).
functor(node0_30, app).         const(app).
gram_sempos(node0_30, n_pron_indef).         const(n_pron_indef).
id(node0_30, t_jihomoravsky49640_txt_001_p1s4a18).         const(t_jihomoravsky49640_txt_001_p1s4a18).
t_lemma(node0_30, ktery).         const(ktery).
%%%%%%%% node0_31 %%%%%%%%%%%%%%%%%%%
node(node0_31).
a_afun(node0_31, atr).         const(atr).
m_form(node0_31, jehoz).         const(jehoz).
m_lemma(node0_31, jenz___ktery__ve_vedl_vete__).         const(jenz___ktery__ve_vedl_vete__).
m_tag(node0_31, p1xxxzs3_______).         const(p1xxxzs3_______).
m_tag0(node0_31,'p'). const('p'). m_tag1(node0_31,'1'). const('1'). m_tag2(node0_31,'x'). const('x'). m_tag3(node0_31,'x'). const('x'). m_tag4(node0_31,'x'). const('x'). m_tag5(node0_31,'z'). const('z'). m_tag6(node0_31,'s'). const('s'). m_tag7(node0_31,'3'). const('3'). 
%%%%%%%% node0_32 %%%%%%%%%%%%%%%%%%%
node(node0_32).
a_afun(node0_32, sb).         const(sb).
m_form(node0_32, totoznost).         const(totoznost).
m_lemma(node0_32, totoznost____3y_).         const(totoznost____3y_).
m_tag(node0_32, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node0_32,'n'). const('n'). m_tag1(node0_32,'n'). const('n'). m_tag2(node0_32,'f'). const('f'). m_tag3(node0_32,'s'). const('s'). m_tag4(node0_32,'1'). const('1'). m_tag10(node0_32,'a'). const('a'). 
%%%%%%%% node0_33 %%%%%%%%%%%%%%%%%%%
node(node0_33).
a_afun(node0_33, atr).         const(atr).
m_form(node0_33, zjistuji).         const(zjistuji).
m_lemma(node0_33, zjistovat__t).         const(zjistovat__t).
m_tag(node0_33, vb_p___3p_aa___).         const(vb_p___3p_aa___).
m_tag0(node0_33,'v'). const('v'). m_tag1(node0_33,'b'). const('b'). m_tag3(node0_33,'p'). const('p'). m_tag7(node0_33,'3'). const('3'). m_tag8(node0_33,'p'). const('p'). m_tag10(node0_33,'a'). const('a'). m_tag11(node0_33,'a'). const('a'). 
%%%%%%%% node0_34 %%%%%%%%%%%%%%%%%%%
node(node0_34).
functor(node0_34, act).         const(act).
gram_sempos(node0_34, n_denot).         const(n_denot).
id(node0_34, t_jihomoravsky49640_txt_001_p1s4a19).         const(t_jihomoravsky49640_txt_001_p1s4a19).
t_lemma(node0_34, policista).         const(policista).
%%%%%%%% node0_35 %%%%%%%%%%%%%%%%%%%
node(node0_35).
a_afun(node0_35, sb).         const(sb).
m_form(node0_35, policiste).         const(policiste).
m_lemma(node0_35, policista).         const(policista).
m_tag(node0_35, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node0_35,'n'). const('n'). m_tag1(node0_35,'n'). const('n'). m_tag2(node0_35,'m'). const('m'). m_tag3(node0_35,'p'). const('p'). m_tag4(node0_35,'1'). const('1'). m_tag10(node0_35,'a'). const('a'). 
edge(node0_0, node0_1).
edge(node0_1, node0_2).
edge(node0_1, node0_3).
edge(node0_3, node0_4).
edge(node0_4, node0_5).
edge(node0_3, node0_6).
edge(node0_3, node0_7).
edge(node0_3, node0_8).
edge(node0_8, node0_9).
edge(node0_8, node0_10).
edge(node0_1, node0_11).
edge(node0_1, node0_12).
edge(node0_12, node0_13).
edge(node0_13, node0_14).
edge(node0_14, node0_15).
edge(node0_13, node0_16).
edge(node0_12, node0_17).
edge(node0_12, node0_18).
edge(node0_18, node0_19).
edge(node0_19, node0_20).
edge(node0_20, node0_21).
edge(node0_19, node0_22).
edge(node0_18, node0_23).
edge(node0_18, node0_24).
edge(node0_24, node0_25).
edge(node0_25, node0_26).
edge(node0_24, node0_27).
edge(node0_24, node0_28).
edge(node0_28, node0_29).
edge(node0_29, node0_30).
edge(node0_30, node0_31).
edge(node0_29, node0_32).
edge(node0_28, node0_33).
edge(node0_28, node0_34).
edge(node0_34, node0_35).
