ucscDB <- dbConnect(MySQL(),user="genome",host= "genome-mysql.soe.ucsc.edu")

result<- dbGetQuery(ucscDB,"show databases;");dbDisconnect(ucscDB);
# sent the myQL databases a mySQL command using the connection ucscDB
# always disconnect from the server fter your queries are done

result   # shows all the possible databses present in the genome server


# hg19 is a human genome that is also present in the databse
# we will try to access it now

hg19<- dbConnect(MySQL(), user="genome",db="hg19",host="genome-mysql.soe.ucsc.edu")
allTables<- dbListTables(hg19)

# we extracted all tables connected with hg19

length(allTables)
# [1] 12464

allTables[1:5]
# [1] "HInv"         "HInvGeneMrna" "acembly"      "acemblyClass" "acemblyPep"  

dbListFields(hg19,"HInv")
# [1] "geneId"    "clusterId" "mrnaAcc"  

dbGetQuery(hg19,"select count(*) from HInv")
#     count(*)
#  1    56419


# databse -> Table -> fields(represent cols in R) ->elements( represent rows in R)

HInv_data<- dbReadTable(hg19,"HInv")
head(HInv_data)
#       geneId  clusterId  mrnaAcc
#1 HIT000000001 HIX0021591 AB002292
#2 HIT000000002 HIX0012341 AB002293
#3 HIT000000003 HIX0012978 AB002294
#4 HIT000000004 HIX0011989 AB002295
#5 HIT000000005 HIX0009425 AB002296
#6 HIT000000006 HIX0003327 AB002297

# extracting a specific subset

query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
sub_data<- fetch(query,n=10)
dim(sub_data)
# [1] 10 22
