/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                         B u c a r e s t e ,   o   f o d a o . . .   |  
 / / |                                                 C o p y r i g h t   2 0 1 5 ,   M e t a Q u o t e s   S o f t w a r e   C o r p .   |  
 / / |                                                                                           h t t p s : / / w w w . m q l 5 . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " T r a b a l h a n d o   p a r a   o   F O R E X   f u n c i o n a r . "  
 # p r o p e r t y   l i n k             " h t t p : / / w w w . s a 2 . c o m . b r "  
  
 # p r o p e r t y   v e r s i o n       " 1 . 3 8 "   / / T r a b a l h a n d o   p a r a   o   F O R E X   f u n c i o n a r  
  
 # i n c l u d e   < b a s i c o . m q h >  
 # i n c l u d e   < O n T r a d e . m q h >  
 # i n c l u d e   < F u n c o e s G e r a i s . m q h >  
  
  
 # i n c l u d e   < I n p u t s _ V a r s . m q h >  
  
 # i n c l u d e   < B u c a r e s t e \ F u n c o e s B u c a r e s t e . m q h >  
 # i n c l u d e   < B u c a r e s t e \ i n p u t s _ b u c a r e s t e . m q h >  
  
  
 # i n c l u d e   < I n d i c a d o r e s \ H i L o . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ P S A R . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ O z y . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ B S I . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ F r a c t a l s . m q h >  
  
 # i n c l u d e   < S e c c a o . m q h >  
 # i n c l u d e   < S t o p s . m q h >  
 # i n c l u d e   < G r a f i c o s . m q h >  
 # i n c l u d e   < M o n t a r R e q u i s i c a o . m q h >  
 # i n c l u d e   < B u c a r e s t e \ I n i t B u c a r e s t e . m q h >  
 # i n c l u d e   < V e r i f i c a I n i t . m q h >  
 # i n c l u d e   < O p e r a c o e s . m q h >  
  
  
  
 i n t   O n I n i t ( )  
 {  
     I n i t _ P a d r a o ( ) ;  
  
     / / E s p e c i f i c o   B u c a r e s t e   M e z z o   M e z z o  
     I n i c i a l i z a _ F u n c s ( ) ;  
  
     i f ( V e r i f i c a I n i t ( )   = =   I N I T _ P A R A M E T E R S _ I N C O R R E C T   | |  
     I n i t B u c a r e s t e ( )   = =   I N I T _ P A R A M E T E R S _ I N C O R R E C T )  
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
     C o m e n t a r i o ( ) ;  
  
     / / E s p e c i f i c o   B u c a r e s t e  
     i f ( O p e r a c a o L o g o D e C a r a = = t r u e   & &     J a Z e r o u = = t r u e   & &   T a D e n t r o D o H o r a r i o ( H o r a r i o I n i c i o , H o r a r i o F i m ) = = t r u e )   P r i m e i r a O p e r a c a o ( ) ;  
     C a l c u l a _ D i r e c a o ( ) ;  
     / / F i m   d o   E s p e c i f i c o   B u c a r e s t e  
  
     Z e r a r O D i a ( ) ;  
 }  
  
 v o i d   O n T i c k ( )  
 {  
     O p e r a c o e s _ N o _ t i c k ( ) ;  
  
     / / E s p e c i f i c o   B u c a r e s t e  
     i f ( I n d i c a d o r T e m p o R e a l   = =   t r u e   & &   U s a _ H i l o   = =   t r u e )             H i L o ( ) ;  
     i f ( I n d i c a d o r T e m p o R e a l   = =   t r u e   & &   U s a _ P S a r   = =   t r u e )             P S a r ( ) ;  
     / / F i m   d o   E s p e c i f i c o   B u c a r e s t e  
 }  
  
 d o u b l e   O n T e s t e r ( )  
 {  
     r e t u r n   L i q u i d e z _ T e s t e _ f i m   -   L i q u i d e z _ T e s t e _ i n i c i o   -     O p e r a c o e s F e i t a s G l o b a i s   *   c u s t o _ o p e r a c a o ;  
 }  
  
 v o i d   O n N e w B a r ( )  
 {  
     / / E s p e c i f i c o   B u c a r e s t e  
     i f ( I n d i c a d o r T e m p o R e a l   = =   f a l s e   & &   U s a _ H i l o   = =   t r u e )             H i L o ( ) ;  
     i f ( I n d i c a d o r T e m p o R e a l   = =   f a l s e   & &   U s a _ P S a r   = =   t r u e )             P S a r ( ) ;  
     i f ( I n d i c a d o r T e m p o R e a l   = =   f a l s e   & &   U s a _ O z y   = =   t r u e )               O z y _ O p e r a ( ) ;  
     i f ( I n d i c a d o r T e m p o R e a l   = =   f a l s e   & &   U s a _ F r a c t a l   = =   t r u e )       F r a c t a l ( ) ;  
     i f ( I n d i c a d o r T e m p o R e a l   = =   f a l s e   & &   U s a _ B S I   = =   t r u e )               B S I ( ) ;  
     / / F i m   d o   E s p e c i f i c o   B u c a r e s t e  
 }  
 