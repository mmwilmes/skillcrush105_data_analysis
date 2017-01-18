library("tm")
library("SnowballC")
library("RColorBrewer")
library("wordcloud")

setwd("/Users/mwilmes/Desktop/skillcrush-104")

# Read the text file
filePath <- "advice.txt"
text <- readLines(filePath)
# Load the data as a corpus
docs <- Corpus(VectorSource(text))
# Transformation is performed using tm_map() function to replace special characters from the text (e.g. “/”, “@” and “|” with space)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Cleaning the text
# the tm_map() to remove unnecessary white space, convert to lower case, remove common stopwords like ‘the’, “we”.
# remove numbers and punctuation with removeNumbers and removePunctuation arguments
# reduce words to their root form (e.g. moved, movement -> move)
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# docs <- tm_map(docs, removeWords, c("")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
#docs <- tm_map(docs, stemDocument)

# Build a term-document matrix (table containing the frequency of the words)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 20)

# Generate the Word cloud
par(mar=c(0,0,0,0), mgp=c(0,0,0), tcl=-0.4)
set.seed(1234)
png("wordcloud.png")
wordcloud(words = d$word, freq = d$freq, min.freq = 3,
          max.words=Inf, random.order=FALSE, rot.per=0.15, 
          colors=brewer.pal(8,"Dark2"))
dev.off()

# display.brewer.pal(7,"RdYlGn")
