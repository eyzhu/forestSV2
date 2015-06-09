# source("http://bioconductor.org/biocLite.R")
# biocLite("IRanges")

##############################################################################
# Determine which samples are from identical twins
##############################################################################

myFiles = list.files(path = ".", "*chr20_calls.Rdata", recursive = T)

allcalls = list()
names = character() 

# getting files
for (currFile in myFiles){
      if ( length(grep("noF", currFile)) == 1  | length(grep("filter", currFile)) == 1 ){
            next
      }
      names = c(names, gsub("F.*","",currFile))
      allcalls = c(allcalls, get(load(currFile)))
}

thresh_dup = 0.4
thresh_del = 0.5

overlap = vector()

for (calls1 in allcalls){
      for (calls2 in allcalls) {
            
            calls1_DUP = calls1[calls1[[2]]=="DUP" & calls1[[1]] > thresh_dup, ]
            calls1_DEL = calls1[calls1[[2]]=="DEL" & calls1[[1]] > thresh_del, ]
            calls2_DUP = calls2[calls2[[2]]=="DUP" & calls2[[1]] > thresh_dup, ]
            calls2_DEL = calls2[calls2[[2]]=="DEL" & calls2[[1]] > thresh_del, ]
            
            calls1_DUP = calls1_DUP$ranges
            calls1_DEL = calls1_DEL$ranges
            calls2_DUP = calls2_DUP$ranges
            calls2_DEL = calls2_DEL$ranges
            
            dup = sum(width(intersect(calls1_DUP, calls2_DUP)))
            del = sum(width(intersect(calls1_DEL, calls2_DEL)))
            
            overlap = c(overlap, dup + del)
      
      }
}

overlap = matrix(overlap,length(allcalls),length(allcalls))
rownames(overlap) = names
colnames(overlap) = names

for (i in 1:nrow(overlap)) {
      for (j in 1:ncol(overlap)) {
            if (i==j){
                  overlap[i,j] = 0
                  next
            }
            overlap[i,j] = overlap[i,j]/( overlap[i,i]+overlap[j,j] )
      }
}


##############################################################################
# Are there any credible denovo mutations
##############################################################################

twin_calls = list(get(load("01C05676F/chr20_calls.Rdata")),get(load("02C10019F/chr20_calls.Rdata")))
#twin2_calls = get(load("02C10019F/chr20_calls.Rdata"))
parent_calls = list(get(load("02C10017F/chr20_calls.Rdata")), get(load("02C10230F/chr20_calls.Rdata")))
#parent2_calls = get(load("02C10230F/chr20_calls.Rdata"))

thresh_dup = 0.4
thresh_del = 0.6
#counter = 1
twin_denovo_mutations = list()

for (twin_call in twin_calls) {
      
      twin_dup = twin_call[twin_call[[2]]=="DUP" & twin_call[[1]] > thresh_dup, ]
      twin_del = twin_call[twin_call[[2]]=="DEL" & twin_call[[1]] > thresh_del, ]
            
      for (parent_call in parent_calls) {

            parent_dup = parent_call[parent_call[[2]]=="DUP" & parent_call[[1]] > thresh_dup, ]
            parent_del = parent_call[parent_call[[2]]=="DEL" & parent_call[[1]] > thresh_del, ]
            
            dup_diff = setdiff(twin_dup$ranges, parent_dup$ranges)
            del_diff = setdiff(twin_del$ranges, parent_del$ranges)
            
            denov_dup = RangedData(dup_diff, type = rep("DUP", length(dup_diff)) )
            denov_del = RangedData(del_diff, type = rep("DEL", length(del_diff)) )
            
            twin_dup = denov_dup[width(denov_dup)>100, ]
            twin_del = denov_del[width(denov_del)>100, ]
      }
      
     twin_denovo_mutations = c(twin_denovo_mutations, rbind(twin_dup, twin_del))
      
}

##############################################################################
# What does size distribution look like
##############################################################################


##############################################################################
# Boxplot of low and high coverage calls
##############################################################################

##############################################################################
# write a function to determine reciprocal overlap (we've got one already, but 
# this is a good exercise)
##############################################################################

reciprocal_overlap = function(lol){
      print("lol")
}

##############################################################################
# what does the distribution of coverage look like for deletion calls? 
# duplications?
##############################################################################

feature_files = list.files(path = "./01C05676F", "*features*", recursive = T)
calls = get(load("./01C05676F/chr20_calls.Rdata"))


for (file in feature_files){
      curr_feature = get(load(paste("./01C05676F/", file, sep="" )))
      
}


