# i n c l u d e   < E x p a n d G r i d . m q h >  
  
 v o i d   N o r m a l i z a _ A r r a y ( d o u b l e &   a r r a y _ e n t r a d a [ ] ,   d o u b l e &   a r r a y _ s a i d a [ ] ,   i n t   s t a r t _ p o i n t   =   0 )   {  
     A r r a y R e s i z e ( a r r a y _ s a i d a , A r r a y R a n g e ( a r r a y _ e n t r a d a , 0 ) ) ;  
  
     d o u b l e   Z _ m i n   =   a r r a y _ e n t r a d a [ A r r a y M i n i m u m ( a r r a y _ e n t r a d a , s t a r t _ p o i n t ) ] ;  
     d o u b l e   Z _ m a x   =   a r r a y _ e n t r a d a [ A r r a y M a x i m u m ( a r r a y _ e n t r a d a , s t a r t _ p o i n t ) ] ;  
  
     d o u b l e   Z _ m a x _ Z m i n   =   Z _ m a x   -   Z _ m i n ;  
     i f ( Z _ m a x _ Z m i n   = =   0   )   Z _ m a x _ Z m i n   =   0 . 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ;  
  
  
     f o r   ( i n t   i   =   s t a r t _ p o i n t ;   i   <   A r r a y R a n g e ( a r r a y _ e n t r a d a , 0 ) ;   i + + )   {  
         a r r a y _ s a i d a [ i ]   =   ( a r r a y _ e n t r a d a [ i ]   -   Z _ m i n )   /   ( Z _ m a x _ Z m i n ) ;  
     }  
 }  
  
 v o i d   N o r m a l i z a c a o _ M a n u a l ( d o u b l e &   a r r a y _ e n t r a d a [ ] ,   d o u b l e &   a r r a y _ s a i d a [ ] ,   i n t   s t a r t _ p o i n t   =   0 ,   d o u b l e   m i n   =   0 ,   d o u b l e   m a x   =   1 0 0 )   {  
     A r r a y R e s i z e ( a r r a y _ s a i d a , A r r a y R a n g e ( a r r a y _ e n t r a d a , 0 ) ) ;  
  
     d o u b l e   Z _ m i n   = m i n ;  
     d o u b l e   Z _ m a x   =   m a x ;  
  
     d o u b l e   Z _ m a x _ Z m i n   =   Z _ m a x   -   Z _ m i n ;  
     i f ( Z _ m a x _ Z m i n   = =   0   )   Z _ m a x _ Z m i n   =   0 . 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 ;  
  
  
     f o r   ( i n t   i   =   s t a r t _ p o i n t ;   i   <   A r r a y R a n g e ( a r r a y _ e n t r a d a , 0 ) ;   i + + )   {  
         a r r a y _ s a i d a [ i ]   =   ( a r r a y _ e n t r a d a [ i ]   -   Z _ m i n )   /   ( Z _ m a x _ Z m i n ) ;  
     }  
 }  
  
  
 / / - - -  
 v o i d   O n S t a r t ( )  
 {  
     s t r i n g   c o l _ c l a s s e s [ ]   =   { " A l p h a " , " B e t a " , " g a m m a " } ;  
     / /   s t r i n g   c l a s s e s [ ]   =   { " a 3 " ,   " a 2 " ,   " n 1 " ,   " b 2 " ,   " b 3 " } ;  
     s t r i n g   c l a s s e s [ ]   =   { " a " ,   " b " ,   " c " } ;  
     E x p a n d G r i d   * g r i d   =   n e w   E x p a n d G r i d ( c o l _ c l a s s e s , c l a s s e s ) ;  
  
  
  
     s t r i n g   l i n h a [ ] ;  
     d o u b l e   n u m e r i c a [ ] ;  
  
  
     / /   f o r   ( i n t   i   =   0 ;   i   <   g r i d . a r r a y . T o t a l ( ) ;   i + + )   {  
     / /       C A r r a y S t r i n g   * c o l u n a _ i d x ;  
     / /       c o l u n a _ i d x   =   g r i d . a r r a y . A t ( i ) ;  
     / /  
     / /           P r i n t ( " [ "   +   c o l _ c l a s s e s [ i ]   +   " , "   +   l i n h a _ n u m   +   " ]   =   "   +   c o l u n a _ i d x . A t ( l i n h a _ n u m ) ) ;  
     / /  
     / /   }  
     A r r a y P r i n t ( c o l _ c l a s s e s ) ;  
  
     d o u b l e   t o t a l _ n u m e r i c o [ ] ;  
  
     A r r a y R e s i z e ( t o t a l _ n u m e r i c o , g r i d . l i n e _ c o u n t ) ;  
  
     f o r   ( i n t   i   =   0 ;   i   <   g r i d . l i n e _ c o u n t ;   i + + )   {  
         g r i d . G e t _ L i n e ( i , l i n h a ) ;  
  
         A r r a y R e s i z e ( n u m e r i c a , A r r a y S i z e ( l i n h a ) ) ;  
  
         f o r   ( i n t   j   =   0 ;   j   <   A r r a y S i z e ( l i n h a ) ;   j + + )   {  
             i f ( l i n h a [ j ]   = =   " a 3 "   | |   l i n h a [ j ]   = =   " b 3 " )   n u m e r i c a [ j ]   =   3 ;  
             i f ( l i n h a [ j ]   = =   " a 2 "   | |   l i n h a [ j ]   = =   " b 2 " )   n u m e r i c a [ j ]   =   5 ;  
             i f ( l i n h a [ j ]   = =   " n 1 " )   n u m e r i c a [ j ]   =   7 ;  
         }  
  
         d o u b l e   t o t a l _ n u m e r i c o _ t e m p ;  
  
  
         f o r   ( i n t   j   =   0 ;   j   <   A r r a y R a n g e ( n u m e r i c a , 0 ) ;   j + + )   {  
             t o t a l _ n u m e r i c o _ t e m p   =   t o t a l _ n u m e r i c o _ t e m p   +   n u m e r i c a [ j ] ;  
         }  
         t o t a l _ n u m e r i c o [ i ]   =   t o t a l _ n u m e r i c o _ t e m p ;  
  
         t o t a l _ n u m e r i c o _ t e m p   =   0 ;  
  
  
  
         A r r a y P r i n t ( l i n h a ) ;  
         / /   A r r a y P r i n t ( n u m e r i c a ) ;  
     }  
  
     A r r a y P r i n t ( t o t a l _ n u m e r i c o ) ;  
  
 N o r m a l i z a _ A r r a y ( t o t a l _ n u m e r i c o , t o t a l _ n u m e r i c o ) ;  
  
     A r r a y P r i n t ( t o t a l _ n u m e r i c o ) ;  
  
  
 f o r   ( i n t   i   =   0 ;   i   <   g r i d . a r r a y . T o t a l ( ) ;   i + + )   {  
     C A r r a y S t r i n g   * c o l u n a _ i d x ;  
     c o l u n a _ i d x   =   g r i d . a r r a y . A t ( i ) ;  
         f o r   ( i n t   j   =   0 ;   j   <   c o l u n a _ i d x . T o t a l ( ) ;   j + + )   {  
             / /   P r i n t ( " [ "   +   c o l _ c l a s s e s [ i ]   +   " , "   +   j   +   " ]   =   "   +   c o l u n a _ i d x . A t ( j ) ) ;  
         }  
 }  
  
  
     d e l e t e ( g r i d ) ;  
 }  
 