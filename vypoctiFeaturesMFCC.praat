clearinfo

souborVystup$ = "parametry.txt"
vstupniAdresar$ = "H1a-d\"

# writeFileLine buď vytvoří nový soubor, a nebo přemaže starý
# dobré pro tvorbu hlavičky tabulky
writeFileLine(souborVystup$, "Vowel", tab$, "c1", tab$, "c2", tab$, "c3", tab$, "c4", tab$, "c5", tab$, "c6", tab$, "c7", tab$, "c8", tab$, "c9", tab$, "c10", tab$, "c11", tab$, "c12", tab$, "trvani")


# všechny TextGrid soubory v adresáři
seznamSouboru = Create Strings as file list... list 'vstupniAdresar$'*.TextGrid
pocetSouboru = Get number of strings

for indSoubor to pocetSouboru
    select seznamSouboru
    souborTG$ = Get string... indSoubor
    # odříznutí posledních 9 znaků, tedy přípony .TextGrid
    souborJmeno$ = left$(souborTG$, length(souborTG$) - 9)
    souborWav$ = souborJmeno$ + ".wav"
    
    #printline Zpracovávám 'souborTG$' a 'souborWav$'

    jmenoWav$ = vstupniAdresar$ + souborWav$
    jmenoTG$ = vstupniAdresar$ + souborTG$
    sndID = Read from file: jmenoWav$
    tgID = Read from file: jmenoTG$

    select tgID
    n = Get number of intervals: 2
    
    # printline 'n'
    
    for i from 2 to n-1
        select tgID
        labPred$ = Get label of interval: 2, i-1
        lab$ = Get label of interval: 2, i
        labPo$ = Get label of interval: 2, i+1
    
        if lab$ = "a" or lab$ = "a:" or lab$ = "e" or lab$ = "e:" or lab$ = "i" or lab$ = "i:" or lab$ = "o" or lab$ = "o:" or lab$ = "u" or lab$ = "u:"
           # printline ['labPred$']['lab$']['labPo$']
            if labPred$ <> "m" and labPred$ <> "n" and labPred$ <> "N" and labPo$ <> "m" and labPo$ <> "n" and labPo$ <> "N"
                # printline Beru!
                t1 = Get start time of interval: 2, i
                t2 = Get end time of interval: 2, i
                trvaniTretina = (t2-t1) / 3
                tStart = t1 + trvaniTretina
                tEnd = t2 - trvaniTretina
	        
                trvani = t2 - t1
                if trvani >= 0.030
                    select sndID
	            
	            sndPartID = Extract part: t1, t2, "Hamming", 1, "no"
	            mfccID = To MFCC: 12, 0.015, 0.005, 100, 100, 0
	            mfccMatrixID = To Matrix
	            
	            hodnotyRadek# = Get all values in row: 1
	            c1 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 2
	            c2 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 3
	            c3 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 4
	            c4 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 5
	            c5 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 6
	            c6 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 7
	            c7 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 8
	            c8 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 9
	            c9 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 10
	            c10 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 11
	            c11 = mean(hodnotyRadek#)
	            hodnotyRadek# = Get all values in row: 12
	            c12 = mean(hodnotyRadek#)
	            
	            select sndPartID
	            Remove
	            select mfccID
	            Remove
	            select mfccMatrixID
	            Remove
 	            
                    appendFileLine(souborVystup$, lab$, tab$, c1, tab$, c2, tab$, c3, tab$, c4, tab$, c5, tab$, c6, tab$, c7, tab$, c8, tab$, c9, tab$, c10, tab$, c11, tab$, c12, tab$, t2-t1)
                endif
            endif
        endif
    endfor
    
    
    
    select sndID
    Remove
    select tgID
    Remove

endfor

select seznamSouboru
Remove

printline Hotovo!
