(defglobal ?*diaframmi* =(create$ f1.0 f1.4 f2 f2.8 f4 f5.6 f8 f11 f16 f22 f32 FONDOSCALA))
(defglobal ?*tempi* = (create$ 1/8000 1/4000 1/2000 1/1000 1/500 1/250 1/125 1/60 1/30 1/15 1/8 1/4 1/2 1 2 4 10 20 30 FONDOSCALA))
(defglobal ?*iso* = (create$ 100 200 400 800 1600 3200 FONDOSCALA))
;+----------------+
;|    FUNZIONI    |
;+----------------+

(deffunction ask-question (?question ?allowed-values)
	   
	(printout t crlf ?question crlf)
	(bind ?i 1)
   
	(while (<= ?i (length$ ?allowed-values)) do
			(printout t ?i ") " (nth ?i ?allowed-values) crlf)
			(bind ?i (+ ?i 1))
	)
   
	(printout t "Scelta: ")
	(bind ?answer (read))
   
	(while  (or (not (integerp ?answer)) (< ?answer 1) (> ?answer (- ?i 1))) do
			(printout t "Scelta non valida!" crlf)
			(printout t crlf ?question crlf)
			(bind ?i 1)
   
			(while (<= ?i (length$ ?allowed-values)) do
					(printout t ?i ") " (nth ?i ?allowed-values) crlf)
					(bind ?i (+ ?i 1))	
			)
			
			(printout t "Scelta: ")
			(bind ?answer (read))
			(printout t crlf)
   )
   
   (nth ?answer ?allowed-values)
)

(deffunction ask-number (?question)
	   
	(printout t crlf ?question crlf)
	(bind ?i 1)
      
	(printout t "Risposta: ")
	(bind ?answer (read))
   
	(while  (or (not (integerp ?answer)) (< ?answer 0) (> ?answer 5)) do
			(printout t "Scelta non valida!" crlf)
			(printout t crlf ?question crlf)
			(bind ?i 1)
   			
			(printout t "Risposta: ")
			(bind ?answer (read))
			(printout t crlf)
   )
   
   ?answer
)

(deffunction aumenta-stop-iso (?attuale ) 
	(bind ?t (member$ ?attuale ?*iso*))
	(if (= ?t (length$ ?*iso*))
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un iso elevata non puoi modificarlo" ?t crlf)
		else (bind ?res (+ ?t 1))
	)
  ?res
)

(deffunction diminuisci-stop-iso (?attuale ) 
	(bind ?t (member$ ?attuale ?*iso*))
	(if (= ?t 1)
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un iso elevata non puoi modificarlo" ?t crlf)
		else (bind ?res (- ?t 1))
	)
  ?res
)

(deffunction aumenta-stop-tempo (?attuale ) 
	(bind ?t (member$ ?attuale ?*tempi*))
	(if (= ?t 1)
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un tempo basso non puoi modificarlo" ?t crlf)
		else (bind ?res (- ?t 1))
	)
  ?res
)

(deffunction diminuisci-stop-tempo (?attuale ) 
	(bind ?t (member$ ?attuale ?*tempi*))
	(if (= ?t (length$ ?*tempi*))
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un tempo elevato non puoi modificarlo" ?t crlf)
		else (bind ?res (+ ?t 1))
	)
  ?res
)

(deffunction aumenta-stop-diaframma (?attuale ) 
	(bind ?t (member$ ?attuale ?*diaframmi*))
	(if (= ?t (length$ ?*diaframmi*))
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un diaframma elevato non puoi modificarlo" ?t crlf)
		else (bind ?res (+ ?t 1))
	)
  ?res
)

(deffunction diminuisci-stop-diaframma (?attuale ) 
	(bind ?t (member$ ?attuale ?*diaframmi*))
	(if (= ?t 1)
		then (bind ?res ?t)
			 (printout t "+++ ATTENZIONE +++ Possiedi un diaframma basso non puoi modificarlo" ?t crlf)
		else (bind ?res (- ?t 1))
	)
  ?res
)


(deffunction percentuale-iso (?valore)
	(* 100 (/ ?valore (length$ ?*iso*)))
)
(deffunction percentuale-tempo (?valore)
	(* 100 (/ ?valore (length$ ?*tempi*)))
)
(deffunction percentuale-diaframma (?valore)
	(* 100 (/ ?valore (length$ ?*diaframmi*)))
)


;+-------------------+
;|  TEMPLATE FATTI   |
;+-------------------+

(deftemplate question
	(slot ID (type INTEGER))
	(slot question-text (type STRING))
	(multislot valid-answers (type SYMBOL))
	(slot help-text (type STRING))
	(slot has-help-image (default FALSE))
	(slot help-image)
	)

(deftemplate tipo-scena
  (slot tipo
	(type SYMBOL)
	(allowed-symbols paesaggio ritratto macro natura sportiva street help )
  )
)

(deftemplate possibilita-modifica
  (slot parametro
	(type SYMBOL)
	(allowed-symbols iso diaframma tempo )
  )
  (slot condizione
	(type SYMBOL)
	(allowed-symbols si no )
  )
)

;;template descrizione della quantità di luce
(deftemplate luce-in-scena
  (slot quantita
	(type SYMBOL)
	(allowed-symbols molta normale poca luce-assente)
  )
)

(deftemplate luogo-scena
  (slot tipo
	(type SYMBOL)
	(allowed-symbols chiuso aperto)
  )
)

(deftemplate proporzione-bilanciamento
	(slot tempo-iso
		(type INTEGER)
	)
	(slot tempo-diaframma
		(type INTEGER)
	)
	(slot iso-diaframma
		(type INTEGER)
	)
	
)
(deftemplate show-image2
	(slot immagine
		(type STRING)
	)
)

;;;************
;;;* DOMANDE  *
;;;************

(deffacts domande
		(question 	(ID 1)
					(question-text "Che tipo di fotografia intendi effettuare?")
					(valid-answers paesaggio ritratto macro natura sportiva street help)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
					
		)
	
		(question 	(ID 2)
					(question-text "in che luogo ti trovi")
					(valid-answers chiuso aperto )
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
					
		)
		(question 	(ID 3)
					(question-text "Che momento della giornata e'?")
					(valid-answers giorno notte)
					(help-text "E' importante sapere in che fase della giornata ci si trova per poter regolare al meglio l'esposizione")
		)
		(question 	(ID 4)
					(question-text "Che tipo di illuminazione e' presente all'interno?")
					(valid-answers Neon Luce-calda Illuminazione-pubblica Naturale)
					(help-text "In base alla tipologia di luce imposteremo il bilanciamento del bianco")
		)
		(question 	(ID 5)
					(question-text "Che quantità di luce e' presente?")
					(valid-answers molta normale poca luce-assente)
					(help-text "Conoscendo la quantita' di luce possiamo iniziare ad esporre regolarmente e\o utilizzare altri accessori")
		)
		(question 	(ID 6)
					(question-text "Che tipo di fotografia intendi effettuare?")
					(valid-answers ritratto macro sportiva)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 7)
					(question-text "Il soggetto principale e' in movimento?")
					(valid-answers si no)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 8)
					(question-text "Vuoi ottenere un effetto mosso del soggetto principale?")
					(valid-answers si no)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 9)
					(question-text "Hai soggetti su piu' piani?")
					(valid-answers si no)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 10)
					(question-text "Sono presenti animali in scena?")
					(valid-answers si no)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 11)
					(question-text "Vuoi dare l'effetto PANNING?")
					(valid-answers si no)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 12)
					(question-text "Dove vuoi concentrare la messa a fuoco?")
					(valid-answers soggetto-principale vicinanza-soggetto-principale tutta-scena)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 13)
					(question-text "Osservando l'esposimetro come risulta essere la tua esposizione?")
					(valid-answers sovraesposta sottoesposta esposta-correttamente)
					(help-text "I paesaggi sono le montagne, i ritratti le persone, macro le cose piccole e la natura non te lo devo stare a dire")
		)
		(question 	(ID 14)
					(question-text "Hai necessita' di aumentare l'esposizione, su cosa pensi di intervenire?")
					(valid-answers profondita'-di-campo tempo-di-esposizione sensibilita'-al-rumore)
					
		)
		(question 	(ID 15)
					(question-text "Controllando l'esposimentro di quanto è sottoesposta la fotografia?")
								
		)
		(question 	(ID 16)
					(question-text "Controllando l'esposimentro di quanto è sovraesposta la fotografia?")
								
		)
		
		
	
	)

;;;****************
;;;* OTHER FACTS *
;;;****************


(deftemplate orario-scena
  (slot orario
	(type SYMBOL)
	(allowed-symbols giorno notte)
  )
)



;;template descrizione del tipo di luce artificiale
(deftemplate tipologia-luce-interno
  (slot tipo
	(type SYMBOL)
	(allowed-symbols Neon Luce-calda Illuminazione-pubblica Naturale)
  )
)

(deftemplate soggetto-in-movimento
  (slot risposta
	(type SYMBOL)
	(allowed-symbols si no)
  )
)

(deftemplate effetto-mosso
  (slot risposta
	(type SYMBOL)
	(allowed-symbols si no)
  )
)

(deftemplate soggetti-piu-piani
  (slot risposta
	(type SYMBOL)
	(allowed-symbols si no)
  )
)

(deftemplate animali-in-scena
  (slot risposta
	(type SYMBOL)
	(allowed-symbols si no)
  )
)

(deftemplate effetto-panning
  (slot risposta
	(type SYMBOL)
	(allowed-symbols si no)
  )
)

(deftemplate fuoco-solo-soggetto-principale
  (slot fuoco
	(type SYMBOL)
	(allowed-symbols soggetto-principale vicinanza-soggetto-principale tutta-scena)
  )
)

(deftemplate esposizione-finale
  (slot stato
	(type SYMBOL)
	(allowed-symbols sovraesposta sottoesposta esposta-correttamente)
  )
  (slot distanza
	(type INTEGER)
	(default 0)
  )
  (slot massimo
	(type SYMBOL)
  )
)

(deftemplate apertura-diaframma
  (slot apertura-minima
	
  )
  (slot apertura-massima

  )
)

(deftemplate iso
  (slot valore-minimo
	
  )
  (slot valore-massimo
	
  )
  (slot asserito
		(type SYMBOL)
		(allowed-symbols si no)
	)
)

(deftemplate focale
  (slot tipo
	(type SYMBOL)
  )
  (slot minimo
	(type SYMBOL)
  )
  (slot massimo
	(type SYMBOL)
  )
)

(deftemplate tempo-scatto
  (slot tempo-minimo
	
  )
  (slot tempo-massimo
	
  )
  (slot asserito
		(type SYMBOL)
		(allowed-symbols si no)
	)
)

(deftemplate correzione
  (slot salvaguardia
	(type SYMBOL)
  )
)
(deftemplate show-help
  (slot avviato
	(type SYMBOL)
  )
)

 

(deffacts asserire-configurazione-iniziale
	(tempo-scatto (asserito no))
	(iso (asserito no))
	(show-help (avviato no))
)






;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-start ""
	(declare (salience 1000))
  =>
	(printout t ”++++BENVENUTO++++” crlf crlf)
  
  )
  
(defrule chiedi-tipo-scena-esterno ""
(declare (salience 20))
	(luogo-scena (tipo aperto))
	?sh<-(show-help (avviato no))
	(question (ID 1)(question-text ?question)
					(valid-answers $?valid-answers)
					(has-help-image ?has-help-image)
					(help-image ?help-image)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text)	
	(if (eq ?has-help-image FALSE) 
	then
		(printout t "Mostra immagine " crlf)
		(assert (show-image2 (immagine "ciaone")))		
	)
	
	(bind ?answer (ask-question ?question ?valid-answers))
	(if (eq ?answer help)
		then (modify ?sh (avviato si))
				(assert (show-image2 (immagine "ciaone")))
		else (assert (tipo-scena (tipo ?answer)))
	)		
 )
 
 (defrule show-help-cose
 (declare (salience 25))
	?sh<-(show-help (avviato si))
	=>
	(printout t "ciaone" crlf)
	(modify ?sh (avviato no))
 )
 
 (defrule chiedi-tipo-scena-interno ""
 (declare (salience 20))
	(luogo-scena (tipo chiuso))
	(question (ID 6)(question-text ?question)
					(valid-answers $?valid-answers)
					(has-help-image ?has-help-image)
					(help-image ?help-image)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )	
	(if (eq ?has-help-image FALSE) 
	then
		(printout t "Mostra immagine " crlf)
		(assert (show-image2 (immagine "ciaone")))		
	)
	
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (tipo-scena (tipo ?answer)))
			
 )
 
 (defrule chiedi-orario-scena ""
 (declare (salience 20))
	(luogo-scena (tipo aperto))
	(question (ID 3)(question-text ?question)
					(valid-answers $?valid-answers)
					(has-help-image ?has-help-image)
					(help-image ?help-image)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )	
	(if (eq ?has-help-image FALSE) 
	then
		(printout t "Mostra immagine " crlf)
		(assert (show-image ?help-image))		
	)
	
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (orario-scena (orario ?answer)))
			
 )
 
 (defrule chiedi-luogo-aperto-chiuso ""
	(declare (salience 20))
	(question (ID 2)(question-text ?question)
					(valid-answers $?valid-answers)
					(has-help-image ?has-help-image)
					(help-image ?help-image)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )	
	(if (eq ?has-help-image FALSE) 
	then
		(printout t "Mostra immagine " crlf)
		(assert (show-image ?help-image))		
	)
	
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (luogo-scena (tipo ?answer)))
			
 )
 
 (defrule chiedi-fonte-illuminazione-interna ""
 (declare (salience 20))
	(luogo-scena(tipo chiuso))
	(question (ID 4)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (tipologia-luce-interno (tipo ?answer)))
 )
 
(defrule chiedi-quantita-luce ""
(declare (salience 20))
	(question (ID 5)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (luce-in-scena (quantita ?answer)))
 )
 
 (defrule chiedi-soggetto-in-movimento ""
 (declare (salience 20))
	(tipo-scena(tipo sportiva))
	(question (ID 7)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (soggetto-in-movimento (risposta ?answer)))
 )
 
 (defrule chiedi-soggetto-in-movimento#2 ""
 (declare (salience 20))
	(tipo-scena(tipo natura))
	(animali-in-scena(risposta si))

	(question (ID 7)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (soggetto-in-movimento (risposta ?answer)))
 )
 
  (defrule chiedi-effetto-mosso ""
  (declare (salience 20))
	(soggetto-in-movimento(risposta si))
	(question (ID 8)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (effetto-mosso (risposta ?answer)))
 )
 
(defrule chiedi-soggetti-piu-piani ""
(declare (salience 20))
	(tipo-scena(tipo ritratto))
	(question (ID 9)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (soggetti-piu-piani (risposta ?answer)))
 )
 
(defrule chiedi-soggetti-piu-piani#2 ""
(declare (salience 20))
	(tipo-scena(tipo sportiva))
	(question (ID 9)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (soggetti-piu-piani (risposta ?answer)))
 )
 
(defrule chiedi-soggetti-piu-piani#3 ""
(declare (salience 20))
	(tipo-scena(tipo natura))
	
	(question (ID 9)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (soggetti-piu-piani (risposta ?answer)))
 )
 
(defrule chiedi-animali-in-scena ""
(declare (salience 20))
	(tipo-scena(tipo natura))
	(question (ID 10)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (animali-in-scena(risposta ?answer)))
 )
 
 (defrule chiedi-effetto-panning ""
 (declare (salience 20))
	(animali-in-scena(risposta si))
	(question (ID 11)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (effetto-panning(risposta ?answer)))
 )
 
 (defrule chiedi-effetto-panning#2 ""
 (declare (salience 20))
	(tipo-scena(tipo street))
	(question (ID 11)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (effetto-panning(risposta ?answer)))
 )
 
 (defrule chiedi-fuoco-solo-soggetto-principale ""
 (declare (salience 20))
	(question (ID 12)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
    (printout t ?help-text )		
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (fuoco-solo-soggetto-principale(fuoco ?answer)))
 )
 

 

 
 ;+------------+
 ;|   OTTICA   |
 ;+------------+
 
(defrule calcolo-ottica#1
	(declare (salience 10))
	(tipo-scena (tipo paesaggio))
	=>
	(assert (focale (tipo grandangolare) (minimo 15mm) (massimo 35mm)))
	(assert (proporzione-bilanciamento (tempo-iso 20) (iso-diaframma 20) (tempo-diaframma 30)))
)

(defrule calcolo-ottica#2
	(declare (salience 10))
	(tipo-scena (tipo ritratto))
	=>
	(assert (focale (tipo medio-teleobbiettivo) (minimo 50mm) (massimo 70mm)))
	(assert (proporzione-bilanciamento (tempo-iso 20) (iso-diaframma 40) (tempo-diaframma 40)))
)

(defrule calcolo-ottica#3
	(declare (salience 10))
	(tipo-scena (tipo macro))
	=>
	(assert (focale (tipo teleobbiettivo-macro) (minimo 180mm) (massimo 300mm)))
	(assert (proporzione-bilanciamento (tempo-iso 20) (iso-diaframma 20) (tempo-diaframma 20)))
)

(defrule calcolo-ottica#4
	(declare (salience 10))
	(tipo-scena (tipo natura))
	=>
	(assert (focale (tipo teleobbiettivo) (minimo 70mm) (massimo 200mm)))
	(assert (proporzione-bilanciamento (tempo-iso 20) (iso-diaframma 20) (tempo-diaframma 20)))
)

(defrule calcolo-ottica#5
	(declare (salience 10))
	(tipo-scena (tipo sportiva))
	=>
	(assert (focale (tipo teleobbiettivo) (minimo 200mm) (massimo 400mm)))
	(assert (proporzione-bilanciamento (tempo-iso 40) (iso-diaframma 20) (tempo-diaframma 40)))
)

(defrule calcolo-ottica#6
	(declare (salience 10))
	(tipo-scena (tipo street))
	=>
	(assert (focale (tipo teleobbiettivo) (minimo 35mm) (massimo 105mm)))
	(assert (proporzione-bilanciamento (tempo-iso 20) (iso-diaframma 20) (tempo-diaframma 20)))
)
 
 
 ;+------------------+
 ;|   CALCOLO ISO    |
 ;+------------------+
 
(defrule calcolo-iso#1
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(luce-in-scena (quantita molta))
	=>
	(modify ?rule (asserito si) (valore-minimo 100) (valore-massimo 200))
)

(defrule calcolo-iso#2
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(luce-in-scena (quantita normale))
	=>
	(modify ?rule (asserito si) (valore-minimo 200) (valore-massimo 800))
)

(defrule calcolo-iso#3
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(luce-in-scena (quantita poca))
	=>
	(modify ?rule (asserito si) (valore-minimo 800) (valore-massimo 1600))
)

(defrule calcolo-iso#4
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(luce-in-scena (quantita luce-assente))
	=>
	(modify ?rule (asserito si) (valore-minimo 3200) (valore-massimo FONDOSCALA))
)

(defrule calcolo-iso#5
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(orario-scena (orario notte))
	(luce-in-scena (quantita molta))
	=>
	(modify ?rule (asserito si)(valore-minimo 200) (valore-massimo 400))
)

(defrule calcolo-iso#6
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(orario-scena (orario notte))
	(luce-in-scena (quantita normale))
	=>
	(modify ?rule (asserito si) (valore-minimo 400) (valore-massimo 1600))
)

(defrule calcolo-iso#7
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(orario-scena (orario notte))
	(luce-in-scena (quantita poca))
	=>
	(modify ?rule (asserito si)(valore-minimo 1600) (valore-massimo 3200))
)

(defrule calcolo-iso#8
	(declare (salience 10))
	?rule<-(iso (asserito no))
	(orario-scena (orario notte))
	(luce-in-scena (quantita luce-assente))
	=>
	(modify ?rule (asserito si) (valore-minimo FONDOSCALA) (valore-massimo FONDOSCALA))
)


 
 ;+------------------+
 ;|  CALCOLO TEMPO   |
 ;+------------------+
 
 (defrule tempo-soggetto-movimento#1
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(effetto-mosso (risposta no))
	(soggetto-in-movimento (risposta si))
	(orario-scena (orario giorno))
	=>
	(modify ?r (tempo-minimo 1/1000) (tempo-massimo FONDOSCALA) (asserito si))
)

(defrule tempo-soggetto-movimento#2
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(effetto-mosso (risposta no))
	(soggetto-in-movimento (risposta si))
	(orario-scena (orario notte))
	=>
	(modify ?r (tempo-minimo 1/500) (tempo-massimo FONDOSCALA) (asserito si))
)

(defrule tempo-soggetto-movimento#3
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(effetto-mosso (risposta si))
	(soggetto-in-movimento (risposta si))
	(orario-scena (orario giorno))
	=>
	(modify ?r (tempo-minimo 1/250) (tempo-massimo 1/1000) (asserito si))
)

(defrule tempo-soggetto-movimento#4
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(effetto-mosso (risposta si))
	(soggetto-in-movimento (risposta si))
	(orario-scena (orario notte))
	=>
	(modify ?r (tempo-minimo 1/250) (tempo-massimo 1/1000) (asserito si))
)
  
 
 (defrule calcolo-tempo-scatto#1
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 100) (valore-massimo 200))
	(apertura-diaframma (apertura-minima f1.0) (apertura-massima f4))
	=>
	
	(modify ?r (asserito si) (tempo-minimo 1/30) (tempo-massimo 1/125))
 )
 
 (defrule calcolo-tempo-scatto#2
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f1.0) (apertura-massima f4))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/125) (tempo-massimo 1/500))
 )
 
 (defrule calcolo-tempo-scatto#3
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f1.0) (apertura-massima f4))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/125) (tempo-massimo 1/500))
 )
 
 (defrule calcolo-tempo-scatto#4
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 800) (valore-massimo 1600))
	(apertura-diaframma (apertura-minima f1.0) (apertura-massima f4))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/500) (tempo-massimo 1/2000))
 )
 
 (defrule calcolo-tempo-scatto#5
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 3200) (valore-massimo FONDOSCALA))
	(apertura-diaframma (apertura-minima f1.0) (apertura-massima f4))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/2000) (tempo-massimo FONDOSCALA))
 )
 
 
  (defrule calcolo-tempo-scatto#6
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 100) (valore-massimo 200))
	(apertura-diaframma (apertura-minima f5.6) (apertura-massima f16))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/15) (tempo-massimo 1/60))
 )
 
 (defrule calcolo-tempo-scatto#7
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f5.6) (apertura-massima f16))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/60) (tempo-massimo 1/250))
 )
 
 (defrule calcolo-tempo-scatto#8
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f5.6) (apertura-massima f16))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/250) (tempo-massimo 1/1000))
 )
 
 (defrule calcolo-tempo-scatto#9
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 800) (valore-massimo 1600))
	(apertura-diaframma (apertura-minima f5.6) (apertura-massima f16))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/1000) (tempo-massimo FONDOSCALA))
 )
 
 (defrule calcolo-tempo-scatto#10
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 3200) (valore-massimo FONDOSCALA))
	(apertura-diaframma (apertura-minima f5.6) (apertura-massima f16))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/2000) (tempo-massimo FONDOSCALA))
 )
 
 (defrule calcolo-tempo-scatto#11
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 100) (valore-massimo 200))
	(apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/2) (tempo-massimo 1/8))
 )
 
 (defrule calcolo-tempo-scatto#12
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/8) (tempo-massimo 1/30))
 )
 
 (defrule calcolo-tempo-scatto#13
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 200) (valore-massimo 800))
	(apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/30) (tempo-massimo 1/125))
 )
 
 (defrule calcolo-tempo-scatto#14
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 800) (valore-massimo 1600))
	(apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/125) (tempo-massimo 1/500))
 )
 
 (defrule calcolo-tempo-scatto#15
	(declare (salience 10))
	?r<-(tempo-scatto (asserito no))
	(iso (valore-minimo 3200) (valore-massimo FONDOSCALA))
	(apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA))
	=>
	(modify ?r (asserito si) (tempo-minimo 1/500) (tempo-massimo FONDOSCALA))
 )
 
 
 ;+-------------------+
 ;| CALCOLO DIAFRAMMA |
 ;+-------------------+
 
(defrule calcolo-apertura-diaframma
	(declare (salience 10))
	(fuoco-solo-soggetto-principale (fuoco soggetto-principale))
	=>
	(assert (apertura-diaframma (apertura-minima f1.0) (apertura-massima f4)))
 )
 
(defrule calcolo-apertura-diaframma#2
	(declare (salience 10))
	(fuoco-solo-soggetto-principale (fuoco vicinanza-soggetto-principale))
	=>
	(assert (apertura-diaframma (apertura-minima f5.6) (apertura-massima f16)))
 )
 
(defrule calcolo-apertura-diaframma#3
	(declare (salience 10))
	(fuoco-solo-soggetto-principale (fuoco tutta-scena))
	=>
	(assert (apertura-diaframma (apertura-minima f22) (apertura-massima FONDOSCALA)))
 )
 
 
 
 
 
 (defrule risultato-finale
 (declare (salience 0))
	(focale(tipo ?tipo)(minimo ?minimo)(massimo ?massimo))
	(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(tempo-scatto (tempo-minimo ?t-min)(tempo-massimo ?t-max))

	(question (ID 13)(question-text ?question)
					(valid-answers $?valid-answers)
					(help-text ?help-text)
	) 
	=>
	(printout t "============================================================" crlf)
	(printout t "Ti consiglio un'ottica di tipo :")
	(printout t ?tipo)
	(printout t " con distanza focale minima di ")
	(printout t ?minimo)
	(printout t " e massima di ")
	(printout t ?massimo crlf)
	(printout t "L'apertura focale deve essere tra questi valori :")
	(printout t ?f-min " e " ?f-max crlf)
	(printout t "IL valore ISO regolalo su :")
	(printout t ?iso-min " e " ?iso-max crlf)
	(printout t "Il tempo di scatto deve essere compreso tra :")
	(printout t ?t-min " e " ?t-max crlf)
	(printout t "============================================================" crlf)
	
	(bind ?answer (ask-question ?question ?valid-answers))
	(assert (esposizione-finale(stato ?answer)))
)

(defrule chiedi-distanza-esposizione#sottoesposizione
	?rule<-(esposizione-finale (stato sottoesposta) (distanza 0))
	(question (ID 15)(question-text ?question)) 
	(apertura-diaframma (apertura-massima ?f-max))
	(iso(valore-massimo ?iso-max))
	(tempo-scatto (tempo-massimo ?t-max))
	=>
	(bind ?answer (ask-number ?question))
	
	
	(bind ?iso-index (member$ ?iso-max ?*iso*))
	(bind ?tempo-index (member$ ?t-max ?*tempi*))
	(bind ?diaframma-index (member$ ?f-max ?*diaframmi*))
	
	(if (> ?iso-index ?tempo-index)
		then (if(> ?iso-index ?diaframma-index)
				then (bind ?res  iso)
				else (bind ?res  diaframma)
			 )
		else (if(> ?tempo-index ?diaframma-index)
				then (bind ?res  tempo)
				else (bind ?res  diaframma)
			 )
	)
	
	(modify ?rule (distanza ?answer) (massimo ?res))
)

(defrule chiedi-distanza-esposizione#sovraesposizione
	?rule<-(esposizione-finale (stato sovraesposta) (distanza 0))
	(question (ID 16)(question-text ?question)) 
	(apertura-diaframma (apertura-massima ?f-max))
	(iso(valore-massimo ?iso-max))
	(tempo-scatto (tempo-massimo ?t-max))
	=>
	(bind ?answer (ask-number ?question))
	
	
	(bind ?iso-index (member$ ?iso-max ?*iso*))
	(bind ?tempo-index (member$ ?t-max ?*tempi*))
	(bind ?diaframma-index (member$ ?f-max ?*diaframmi*))
	
	(if (> ?iso-index ?tempo-index)
		then (if(> ?iso-index ?diaframma-index)
				then (bind ?res  iso)
				else (bind ?res  diaframma)
			 )
		else (if(> ?tempo-index ?diaframma-index)
				then (bind ?res  tempo)
				else (bind ?res  diaframma)
			 )
	)
	
	(modify ?rule (distanza ?answer) (massimo ?res))
)


;+---------------------------------+
;|  FASE DI AUTO-SOVRAESPOSIZIONE  |
;+---------------------------------+

(defrule modifica-esposizione-diaframma-vs-iso
	
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	
	(proporzione-bilanciamento (iso-diaframma ?valore))
	=>
	(bind ?index-f (member$ ?f-max ?*diaframmi*))
	(bind ?index-max (aumenta-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (aumenta-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	(if(!= ?index-max (member$ ?iso-max ?*iso*))
		then (if(<= ?valore (abs(- (percentuale-diaframma ?index-f) (percentuale-iso ?index-max) )))   ;controllare la distanza
				then(modify ?iso-rule (valore-massimo ?new-max) (valore-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro iso) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)




(defrule modifica-esposizione-diaframma-vs-tempo

	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (tempo-diaframma ?valore) )
	=>
	(bind ?index-f (member$ ?f-max ?*diaframmi*))
	(bind ?index-max (aumenta-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (aumenta-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	(if(!= ?index-min (member$ ?t-min ?*tempi*))
		then (if(<= ?valore (abs(- (percentuale-diaframma ?index-f) (percentuale-tempo ?index-max) )))   ;controllare la distanza
				then(modify ?tempo-rule (tempo-massimo ?new-max) (tempo-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro tempo) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
	
)

(defrule modifica-esposizione-diaframma-vs-diaframma

	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	?p-rule<-(proporzione-bilanciamento (tempo-diaframma ?valore) (iso-diaframma ?valore2))
	?pos-tempo<-(possibilita-modifica (parametro tempo) (condizione si))
	?pos-iso<-(possibilita-modifica (parametro iso) (condizione si))
	=>
	
	
	(bind ?index-max (diminuisci-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (diminuisci-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-min (member$ ?f-min ?*diaframmi*))
		then  (modify ?f-rule (apertura-minima  ?new-min) (apertura-massima ?new-max))
			  (retract ?pos-tempo)
			  (retract ?pos-iso)
			  (bind ?new-val (- ?distanza 1))
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
	
)

(defrule modifica-esposizione-tempo-vs-iso
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(proporzione-bilanciamento (tempo-iso ?valore))
	=>
	(bind ?index-t (member$ ?t-max ?*tempi*))
	
	(bind ?index-max (aumenta-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (aumenta-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	
	(if(!= ?index-max (member$ ?iso-max ?*iso*))
		then (if(<= ?valore (abs(- (percentuale-tempo ?index-t) (percentuale-iso ?index-max) )))   ;controllare la distanza
				then(modify ?iso-rule (valore-massimo ?new-max) (valore-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro iso) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)

(defrule modifica-esposizione-tempo-vs-diaframma
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (tempo-diaframma ?valore) )
	=>
	(bind ?index-t (member$ ?t-max ?*tempi*))
	
	(bind ?index-max (diminuisci-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (diminuisci-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-min (member$ ?f-min ?*diaframmi*))
		then (if(<= ?valore (abs(- (percentuale-tempo ?index-t) (percentuale-diaframma ?index-max) )))   ;controllare la distanza
				then(modify ?f-rule (apertura-massima ?new-max) (apertura-minima ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
)

(defrule modifica-esposizione-tempo-vs-tempo
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?p-rule<-(proporzione-bilanciamento (tempo-diaframma ?valore) (tempo-iso ?valore2))
	?pos-diaframma<-(possibilita-modifica (parametro diaframma) (condizione si))
	?pos-iso<-(possibilita-modifica (parametro iso) (condizione si))
	=>
		
	(bind ?index-max (aumenta-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (aumenta-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	
	(if(!= ?index-min (member$ ?t-min ?*tempi*))
		then (modify ?tempo-rule (tempo-minimo  ?new-min) (tempo-massimo ?new-max))
			  (bind ?new-val (- ?distanza 1))
			  (retract ?pos-diaframma)
			  (retract ?pos-iso)
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-tempo
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	?t-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(proporzione-bilanciamento (tempo-iso ?valore))
	=>
	(bind ?index-iso (member$ ?iso-max ?*iso*))
	
	(bind ?index-max (aumenta-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (aumenta-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	
	(if(!= ?index-min (member$ ?t-min ?*tempi*))
		then (if(<= ?valore (abs(- (percentuale-iso ?index-iso) (percentuale-tempo ?index-max) )))   ;controllare la distanza
				then(modify ?t-rule (tempo-massimo ?new-max) (tempo-minimo ?new-min))
				(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro tempo) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-diaframma
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (iso-diaframma ?valore) )
	=>
	(bind ?index-iso (member$ ?iso-max ?*iso*))
	
	(bind ?index-max (diminuisci-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (diminuisci-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-min (member$ ?f-min ?*diaframmi*))
		then (if(<= ?valore (abs(- (percentuale-iso ?index-iso) (percentuale-diaframma ?index-max) )))   ;controllare la distanza
				then(modify ?f-rule (apertura-massima ?new-max) (apertura-minima ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)	
				else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-iso
	?stato<-(esposizione-finale (stato sottoesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?p-rule<-(proporzione-bilanciamento (iso-diaframma ?valore) (tempo-iso ?valore2))
	?pos-tempo<-(possibilita-modifica (parametro tempo) (condizione si))
	?pos-diaframma<-(possibilita-modifica (parametro diaframma) (condizione si))
	=>
		
	(bind ?index-max (aumenta-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (aumenta-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	
	(if(!= ?index-max (member$ ?iso-max ?*iso*))
		then (modify ?iso-rule (valore-minimo  ?new-min) (valore-massimo ?new-max))
			  (bind ?new-val (- ?distanza 1))
			  (retract ?pos-tempo)
			  (retract ?pos-diaframma)
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)


;+---------------------------------+
;|  FASE DI AUTO-SOTTOESPOSIZIONE  |
;+---------------------------------+

(defrule modifica-esposizione-diaframma-vs-iso#sottoesposizione
	
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	
	(proporzione-bilanciamento (iso-diaframma ?valore))
	=>
	(bind ?index-f (member$ ?f-max ?*diaframmi*))
	(bind ?index-max (diminuisci-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (diminuisci-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	(if(!= ?index-min (member$ ?iso-min ?*iso*))
		then (if(<= ?valore (abs(- (percentuale-diaframma ?index-f) (percentuale-iso ?index-max) )))   ;controllare la distanza
				then(modify ?iso-rule (valore-massimo ?new-max) (valore-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro iso) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)




(defrule modifica-esposizione-diaframma-vs-tempo#sottoesposizione

	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (tempo-diaframma ?valore) )
	=>
	(bind ?index-f (member$ ?f-max ?*diaframmi*))
	(bind ?index-max (diminuisci-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (diminuisci-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	(if(!= ?index-max (member$ ?t-max ?*tempi*))
		then (if(<= ?valore (abs(- (percentuale-diaframma ?index-f) (percentuale-tempo ?index-max) )))   ;controllare la distanza
				then(modify ?tempo-rule (tempo-massimo ?new-max) (tempo-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro tempo) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
	
)

(defrule modifica-esposizione-diaframma-vs-diaframma#sottoesposizione

	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo diaframma))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	?p-rule<-(proporzione-bilanciamento (tempo-diaframma ?valore) (iso-diaframma ?valore2))
	?pos-tempo<-(possibilita-modifica (parametro tempo) (condizione si))
	?pos-iso<-(possibilita-modifica (parametro iso) (condizione si))
	=>
	
	
	(bind ?index-max (aumenta-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (aumenta-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-max (member$ ?f-max ?*diaframmi*))
		then  (modify ?f-rule (apertura-minima  ?new-min) (apertura-massima ?new-max))
			  (retract ?pos-tempo)
			  (retract ?pos-iso)
			  (bind ?new-val (- ?distanza 1))
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
	
)

(defrule modifica-esposizione-tempo-vs-iso#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(proporzione-bilanciamento (tempo-iso ?valore))
	=>
	(bind ?index-t (member$ ?t-max ?*tempi*))
	
	(bind ?index-max (diminuisci-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (diminuisci-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	
	(if(!= ?index-min (member$ ?iso-min ?*iso*))
		then (if(<= ?valore (abs(- (percentuale-tempo ?index-t) (percentuale-iso ?index-max) )))   ;controllare la distanza
				then(modify ?iso-rule (valore-massimo ?new-max) (valore-minimo ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro iso) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)

(defrule modifica-esposizione-tempo-vs-diaframma#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (tempo-diaframma ?valore) )
	=>
	(bind ?index-t (member$ ?t-max ?*tempi*))
	
	(bind ?index-max (aumenta-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (aumenta-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-max (member$ ?f-max ?*diaframmi*))
		then (if(<= ?valore (abs(- (percentuale-tempo ?index-t) (percentuale-diaframma ?index-max) )))   ;controllare la distanza
				then(modify ?f-rule (apertura-massima ?new-max) (apertura-minima ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
)

(defrule modifica-esposizione-tempo-vs-tempo#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo tempo))
	?tempo-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	?p-rule<-(proporzione-bilanciamento (tempo-diaframma ?valore) (tempo-iso ?valore2))
	?pos-diaframma<-(possibilita-modifica (parametro diaframma) (condizione si))
	?pos-iso<-(possibilita-modifica (parametro iso) (condizione si))
	=>
		
	(bind ?index-max (diminuisci-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (diminuisci-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	
	(if(!= ?index-min (member$ ?t-min ?*tempi*))
		then (modify ?tempo-rule (tempo-minimo  ?new-min) (tempo-massimo ?new-max))
			  (bind ?new-val (- ?distanza 1))
			  (retract ?pos-diaframma)
			  (retract ?pos-iso)
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-tempo#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	?t-rule<-(tempo-scatto (tempo-massimo ?t-max) (tempo-minimo ?t-min))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(proporzione-bilanciamento (tempo-iso ?valore))
	=>
	(bind ?index-iso (member$ ?iso-max ?*iso*))
	
	(bind ?index-max (diminuisci-stop-tempo ?t-max))
	(bind ?new-max (nth$ ?index-max ?*tempi*))
	(bind ?index-min (diminuisci-stop-tempo ?t-min))
	(bind ?new-min (nth$ ?index-min ?*tempi*))
	
	(if(!= ?index-max (member$ ?t-max ?*tempi*))
		then (if(<= ?valore (abs(- (percentuale-iso ?index-iso) (percentuale-tempo ?index-max) )))   ;controllare la distanza
				then(modify ?t-rule (tempo-massimo ?new-max) (tempo-minimo ?new-min))
				(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)
				else (assert (possibilita-modifica (parametro tempo) (condizione si)))
			)
		else (assert (possibilita-modifica (parametro tempo) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-diaframma#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?f-rule<-(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(proporzione-bilanciamento (iso-diaframma ?valore) )
	=>
	(bind ?index-iso (member$ ?iso-max ?*iso*))
	
	(bind ?index-max (aumenta-stop-diaframma ?f-max))
	(bind ?new-max (nth$ ?index-max ?*diaframmi*))
	(bind ?index-min (aumenta-stop-diaframma ?f-min))
	(bind ?new-min (nth$ ?index-min ?*diaframmi*))
	
	(if(!= ?index-max (member$ ?f-max ?*diaframmi*))
		then (if(<= ?valore (abs(- (percentuale-iso ?index-iso) (percentuale-diaframma ?index-max) )))   ;controllare la distanza
				then(modify ?f-rule (apertura-massima ?new-max) (apertura-minima ?new-min))
					(bind ?new-val (- ?distanza 1))
					(if (= ?new-val 0)
						then (retract ?stato)
						else (modify ?stato (distanza ?new-val))
					)	
				else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
			 )
		else (assert (possibilita-modifica (parametro diaframma) (condizione si)))
	)
)

(defrule modifica-esposizione-iso-vs-iso#sottoesposizione
	?stato<-(esposizione-finale (stato sovraesposta) (distanza ?distanza&:(> ?distanza 0)) (massimo iso))
	?iso-rule<-(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	?p-rule<-(proporzione-bilanciamento (iso-diaframma ?valore) (tempo-iso ?valore2))
	?pos-tempo<-(possibilita-modifica (parametro tempo) (condizione si))
	?pos-diaframma<-(possibilita-modifica (parametro diaframma) (condizione si))
	=>
		
	(bind ?index-max (diminuisci-stop-iso ?iso-max))
	(bind ?new-max (nth$ ?index-max ?*iso*))
	(bind ?index-min (diminuisci-stop-iso ?iso-min))
	(bind ?new-min (nth$ ?index-min ?*iso*))
	
	(if(!= ?index-min (member$ ?iso-min ?*iso*))
		then (modify ?iso-rule (valore-minimo  ?new-min) (valore-massimo ?new-max))
			  (bind ?new-val (- ?distanza 1))
			  (retract ?pos-tempo)
			  (retract ?pos-diaframma)
			  (if (= ?new-val 0)
					then (retract ?stato)
					else (modify ?stato (distanza ?new-val))
			    )
		else (assert (possibilita-modifica (parametro iso) (condizione si)))
	)
)

(defrule basta-modifiche
	(possibilita-modifica (parametro iso) (condizione si))
	(possibilita-modifica (parametro tempo) (condizione si))
	(possibilita-modifica (parametro diaframma) (condizione si))
	(apertura-diaframma (apertura-minima ?f-min)(apertura-massima ?f-max))
	(iso (valore-minimo ?iso-min)(valore-massimo ?iso-max))
	(tempo-scatto (tempo-minimo ?t-min)(tempo-massimo ?t-max))
	
	=>
	
	(printout t "NON PUOI PIU' SOVRAESPORRE SENZA PERDERE LA CARATTERISTICA DELLA TUA FOTO" crlf)
	(printout t "============================================================" crlf)
	(printout t "L'apertura focale la modifichiamo tra questi valori :")
	(printout t ?f-min " e " ?f-max crlf)
	(printout t "IL valore ISO lo modifichiamo tra :")
	(printout t ?iso-min " e " ?iso-max crlf)
	(printout t "Il tempo di scatto lo modifichiamo tra :")
	(printout t ?t-min " e " ?t-max crlf)
	(printout t "============================================================" crlf)
	(halt)
)
 
(defrule mostra-immagine
	(declare (salience 25))
	?fatto<-(show-image2 (immagine ?img))
	=>
	(retract ?fatto)

)
 
 	





	
	
	
 
 