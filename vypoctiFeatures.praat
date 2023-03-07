clearinfo

souborVystup$ = "parametry.txt"
vstupniAdresar$ = "H1a-d\"

# writeFileLine buď vytvoří nový soubor, a nebo přemaže starý
# dobré pro tvorbu hlavičky tabulky
writeFileLine(souborVystup$, "Vowel", tab$, "F1", tab$, "F2", tab$, "F3", tab$, "trvani")


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

    select sndID
    formant1ID = To Formant (burg): 0, 5, 5500, 0.025, 50
    
    form2Vytvoren = 0

    formMin = Get minimum number of formants
    if formMin >= 3
        formant2ID = Track: 3, 550, 1650, 2750, 3850, 4950, 1, 1, 1
        form2Vytvoren = 1
    endif
    
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
    
               if form2Vytvoren = 1
                   select formant2ID
               else
                   select formant1ID
               endif

               f1 = Get mean: 1, tStart, tEnd, "hertz"
               f2 = Get mean: 2, tStart, tEnd, "hertz"
               f3 = Get mean: 3, tStart, tEnd, "hertz"
    
               appendFileLine(souborVystup$, lab$, tab$, f1, tab$, f2, tab$, f3, tab$, t2-t1)
            endif
        endif
    endfor
    
    
    
    select sndID
    Remove
    select tgID
    Remove
    select formant1ID
    Remove
    if form2Vytvoren = 1
        select formant2ID
        Remove
    endif

endfor

select seznamSouboru
Remove

printline Hotovo!
