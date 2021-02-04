### Challenge 1:

# In the data directory, you will find 5 csv (comma-separated values) files. 
# Each file corresponds to water temperature data from a different lake at UNDERC, 
# where the LakeID corresponds to the two letter ID in the file name. Write a 
# custom function to calculate the average water temperature of each lake at some 
# depth. We want to use this function for multiple different lakes and different
# depths, so write the function so that the LakeID and depth are passed as 
# arguments. Return a dataframe with one row and three columns.

lakeTemp <- function(lakeID, depth){
  # read in csv
  data=read.csv(paste("data/", lakeID, ".csv", sep=""), stringsAsFactors = F)
  # subset the data to certain depth
  data=data[data$depthTop==depth,]
  
  # Calculate mean temperature
  meanT=mean(data$temp)
  # Create dataframe
  output=data.frame(lakeID=lakeID, depth_m=depth, meanTemp=meanT)
  # Return dataframe to user
  return(output)
  
}

lakeTemp(lakeID="CR", depth=3)

### Challenge 2:

# Modify your custom function from Challenge 1 to calculate the average water 
# temperature of every lake in the data directory. Hint 1: Pass the directory 
# name as an argument. Hint 2: Use a for loop to loop through every lake in the 
# directory.

lakeTempDir <- function(dir, depth){
  # Get vector of every file in the directory
  files=list.files(dir)
  
  # Preallocate outputs as vectors
  # (dataframes are slow in a for loop and matrices mess up the data type)
  lakeID=as.character(rep(NA, length(files)))
  depth_m=rep(NA, length(files))
  tempC=rep(NA, length(files))
  
  for(i in 1:length(files)){
    # Read in csv
    data=read.csv(paste(dir, files[i], sep=""), stringsAsFactors = F)
    # Subset the data to certain depth
    data=data[data$depthTop==depth,]
    
    # Create lakeID and store in ith position of the lakeID vector
    lakeID[i]=gsub(".csv", "", files[i])
    # Store depth in the ith position of the depth_m vector
    depth_m[i]=depth
    # Calculate mean temperature and store in ith position of the tempC vector
    tempC[i]=mean(data$temp)
  }
  # Column vectors into a dataframe 
  output=data.frame(lakeID, depth_m, tempC)
  # Return dataframe to user
  return(output)
}

lakeTempDir(dir="data/", depth=0)

