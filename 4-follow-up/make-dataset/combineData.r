


# read data

dataDir=Sys.getenv('PROJECT_DATA')
phenos = read.table(paste(dataDir,'/phenotypes/derived/nervous-phenos.csv',sep=''), header=1,sep=",")
snps = read.table(paste(dataDir,'/snps/nervousness-snps-withPhenIds.csv',sep=''), header=1,sep=",")
score96 = read.table(paste(dataDir,'/snps/snp-score96-withPhenIds-subset.csv',sep=''), header=1, sep=",")



# merge

datax = merge(snps, phenos, by='eid', all=FALSE)
datax = merge(datax, score96, by='eid', all=FALSE)

print(dim(datax))

# add PCs 

pcs = read.table(paste(dataDir,'/phenotypes/derived/confounders-PHESANT-followup-pcs40.csv',sep=''), header=1, sep=",")
pcs[,which(colnames(pcs)=="x31_0_0")] = NULL
pcs[,which(colnames(pcs)=="x21022_0_0")] = NULL


datax = merge(datax, pcs, by='eid', all=FALSE)


print(dim(datax))



# save to file

write.table(datax, paste(dataDir,'/phenotypes/derived/nervous-dataset.csv',sep=''), quote=FALSE, row.names=FALSE, sep=',', na="")


