/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                     H o l o d e c k ,   T U D O   �   V I R T U A L |  
 / / |                                                 C o p y r i g h t   2 0 1 7 ,   S a 2   I N V E S T M E N T                         |  
 / / |                                                                                           h t t p s : / / w w w . m q l 5 . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " T a m b � m   c o n h e c i d o   c o m o   E s t r e i t o   d e   1 0 0 . "  
 # p r o p e r t y   l i n k             " h t t p : / / w w w . s a 2 . c o m . b r "  
  
 # p r o p e r t y   v e r s i o n       " 1 . 0 "   / / P e g a n d o   [ 1 ]   ! =   [ 2 ]   n o   H i L o  
  
 # i n c l u d e   < b a s i c o . m q h >  
 # i n c l u d e   < O n T r a d e . m q h >  
 # i n c l u d e   < F u n c o e s G e r a i s . m q h >  
  
  
 # i n c l u d e   < I n p u t s _ V a r s . m q h >  
  
 / /   # i n c l u d e   < B u c a r e s t e \ F u n c o e s B u c a r e s t e . m q h >  
 / /   # i n c l u d e   < B u c a r e s t e \ i n p u t s _ b u c a r e s t e . m q h >  
  
  
 # i n c l u d e   < H o l o d e c k \ I n p u t s _ H o l o d e c k . m q h >  
 # i n c l u d e   < H o l o d e c k \ F u n c o e s _ H o l o d e c k . m q h >  
  
 # i n c l u d e   < S e c c a o . m q h >  
 # i n c l u d e   < S t o p s . m q h >  
 # i n c l u d e   < G r a f i c o s . m q h >  
 # i n c l u d e   < M o n t a r R e q u i s i c a o . m q h >  
 / / # i n c l u d e   < B u c a r e s t e \ I n i t B u c a r e s t e . m q h >  
 # i n c l u d e   < V e r i f i c a I n i t . m q h >  
 # i n c l u d e   < O p e r a c o e s . m q h >  
  
  
  
 i n t   O n I n i t ( )  
 {  
     I n i t _ P a d r a o ( ) ;  
  
       I n i t _ H o l o ( ) ;  
  
     i f ( V e r i f i c a I n i t ( )   = =   I N I T _ P A R A M E T E R S _ I N C O R R E C T )  
     {  
         r e t u r n ( I N I T _ P A R A M E T E R S _ I N C O R R E C T ) ;  
     }  
     e l s e  
     {  
         r e t u r n   I N I T _ S U C C E E D E D ;  
     }  
     / / F i m   d o   E s p e c i f i c o   B u c a r e s t e  
 }  
  
 v o i d   O n T i m e r ( )  
 {  
     I n i c i a D i a ( ) ;  
  
   C o m e n t a r i o ( ) ;  
  
     Z e r a r O D i a ( ) ;  
 }  
  
 v o i d   O n T i c k ( )  
 {  
     H o l o _ N o _ T i c k ( ) ;  
     O p e r a c o e s _ N o _ t i c k ( ) ;  
  
  
 }  
  
 d o u b l e   O n T e s t e r ( )  
 {  
     r e t u r n   L i q u i d e z _ T e s t e _ f i m   -   L i q u i d e z _ T e s t e _ i n i c i o   -     O p e r a c o e s F e i t a s G l o b a i s   *   c u s t o _ o p e r a c a o   *   L o t e s ;  
 }  
  
 v o i d   O n N e w B a r ( )  
 {  
  
  
 }  
 