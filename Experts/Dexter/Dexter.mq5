# p r o p e r t y   c o p y r i g h t   " D e x t e r ,   o p e r a   n a   t e n d e n c i a   d e p o i s   d a   F O R � A   c o n f i r m a r . "  
 # p r o p e r t y   l i n k             " h t t p : / / w w w . s a 2 . c o m . b r "  
 s t r i n g   N o m e _ R o b o   =   " D e x m a n " ;    
 # p r o p e r t y   v e r s i o n       " 1 . 0 1 "   / / I n i c i o   d o s   t r a b a l h o s   D E X T E R I A N O S   O O P  
 # i n c l u d e   < I n p u t s _ V a r s . m q h >  
 # i n c l u d e   < b a s i c o . m q h >  
 # i n c l u d e   < O n T r a d e . m q h >  
 # i n c l u d e   < F u n c o e s G e r a i s . m q h >  
  
  
  
 # i n c l u d e   < D e x t e r \ f u n c o e s _ d e x t e r . m q h >  
 # i n c l u d e   < D e x t e r \ i n p u t s _ d e x t e r . m q h >  
 # i n c l u d e   < D e x t e r \ i n i t _ d e x t e r . m q h >  
  
 # i n c l u d e   < I n d i c a d o r e s \ H i L o . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ P S A R . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ O z y . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ B S I . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ R S I . m q h >  
 # i n c l u d e   < I n d i c a d o r e s \ F r a c t a l s . m q h >  
  
 # i n c l u d e   < S e c c a o . m q h >  
 # i n c l u d e   < S t o p s . m q h >  
 # i n c l u d e   < G r a f i c o s . m q h >  
 # i n c l u d e   < M o n t a r R e q u i s i c a o . m q h >  
 # i n c l u d e   < D e x t e r \ i n i t _ d e x t e r . m q h >  
 # i n c l u d e   < V e r i f i c a I n i t . m q h >  
 # i n c l u d e   < O p e r a c o e s . m q h >  
  
  
 i n t   O n I n i t ( )  
 {  
  
 I n i t _ P a d r a o ( ) ;  
  
  
  
     / / E s p e c i f i c o   B u c a r e s t e   M e z z o   M e z z o  
  
     I n i c i a l i z a _ F u n c s ( ) ;  
  
  
  
     i f ( V e r i f i c a I n i t ( )   = =   I N I T _ P A R A M E T E R S _ I N C O R R E C T   | |  
    
     I n i t B u c a r e s t e ( )   = =   I N I T _ P A R A M E T E R S _ I N C O R R E C T )   / / B E M   E R R A D O  
  
     {  
  
         r e t u r n ( I N I T _ P A R A M E T E R S _ I N C O R R E C T ) ;  
  
     }  
  
     e l s e  
  
     {  
  
         r e t u r n   I N I T _ S U C C E E D E D ;  
  
     }  
  
     / / F i m   d o   E s p e c i f i c o   B u c a r e s t e  
 }  
  
 v o i d   O n T i m e r ( )  
 {  
 I n i c i a D i a ( ) ;  
  
     C o m e n t a r i o ( ) ;  
  
     O p e r a c o e s _ N o _ T i m e r ( ) ;  
  
     Z e r a r O D i a ( ) ;  
  
 }  
  
 v o i d   O n T i c k ( )  
 {  
  
     D e t e c t a N o v a B a r r a ( ) ;  
       C o m e n t a r i o _ D e x t e r ( ) ;  
           O p e r a c o e s _ N o _ t i c k ( ) ;  
  
  
 }  
  
 v o i d   O n N e w B a r ( )  
 {  
  
 A v a l i a _ D e x t e r ( ) ;  
  
  
 }  
  
 d o u b l e   O n T e s t e r ( )  
 {  
         r e t u r n   L i q u i d e z _ T e s t e _ f i m   -   L i q u i d e z _ T e s t e _ i n i c i o   -     O p e r a c o e s F e i t a s G l o b a i s   *   c u s t o _ o p e r a c a o ;  
  
 }  
  
  
 