from bs4 import BeautifulSoup
import glob
import os

os.chdir("/Users/mwilmes/Desktop/skillcrush-104/advice/")

all = 0
new = 0
skillcrush = 0
nosection = 0
nosec = []

for filename in glob.glob("*.html"):
    file = open(filename, 'r', encoding='utf-8')
    soup = BeautifulSoup(file, 'html.parser')
    section = soup.section
    all += 1
    if section:
        cleantext = section.get_text()
        oneword = "".join(cleantext.split())
        if oneword != "Confusionisyourfriend!Whenyoustartprogrammingyourfirstwebappyouaredoingsomethingthatyouhaveneverdonebefore.It'sanewchallenge,anewopportunity,andinthecaseofsoftwaredevelopment,somethingsospecificthatit'sprobablyneverbeendonebefore.Confusion,therefore,isasignthatyouareheadingintherightdirection.It'sasignalthatyouhaveengagedintheproblemsolvingpursuitthatismathandtechnologyandthatit'stimeforyoutodigdeeperandkeepgoingbecauseclarityawaits.Suspendeddisbeliefplaysanimportantrole.Whenyouarelearninganewtechnology,whetheryouarelearningtowriteyourfirstprogramminglanguage,orjustthelatestframework,yougothroughthisuncomfortablephasewhereyouknowthatthecodeyouarelookingatisdoingthisTHINGbutyoudon'tunderstandHOWexactlyit'shappening.Thisisanormalpartoftheprocessoflearninganewtechnology,andinfact,it'sacriticalpartoftheprocess.Youseewhenyouencounteranewprogramminglanguagepartofyourlearningprocessincludeslearningtotrainyoureye.Thewaytotrainyoureyeistoreadagooddealofcodeevenwhenyoudon'ttotallyunderstandwhatit'sdoing.":
            new += 1
            with open("advice.txt", "a") as myfile:
                myfile.write(cleantext)
        else:
            skillcrush += 1
    else:
        nosection += 1
        nosec.append(filename)

print('all: ', all)
print('no section: ', nosection)
print('sk :', skillcrush)
print('new: ', new)
print(skillcrush + new)
