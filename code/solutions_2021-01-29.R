### Challenge 1:

# Create the function
lakeTemp1 <- function(lakeID, depth){   # Define inputs
  # Read in csv
  data=read.csv(paste0("data/", lakeID, ".csv"), stringsAsFactors = F)
  # Subset to only observations at depth
  data=data[data$depthTop==depth,]
  # Calculate mean temperature
  meanT=mean(data$temp, na.rm = T)
  # Create dataframe
  df=data.frame(lakeID=lakeID, depth_m=depth, meanTemp_C=meanT)
  # Return dataframe to user
  return(df)
}

lakeTemp1(lakeID="WL", depth=0)
lakeTemp1(lakeID="CR", depth=0)
lakeTemp1(lakeID="HB", depth=0)
lakeTemp1(lakeID="EL", depth=0)
lakeTemp1(lakeID="MO", depth=0)

### Challenge 2:
# Create the function
lakeTemp2 <- function(dir, depth){   # Define inputs
  # Get vector of every file in the directory
  files=list.files(dir)
  # Create your output dataframe 
  df=data.frame()
  # Use a for loop to loop through every file
  for(i in 1:length(files)){
    print(files[i])
    # Read in csv
    data=read.csv(paste0("data/", files[i]), stringsAsFactors = F)
    # Subset to only observations at depth
    data=data[data$depthTop==depth,]
    # Calculate mean temperature
    meanT=mean(data$temp, na.rm = T)
    # Create dataframe
    temp=data.frame(lakeID=gsub(".csv", "", files[i]), depth_m=depth, meanTemp_C=meanT)
    # Add the row to the bottom of the output
    df=rbind(df, temp)
  }
  # Return dataframe to user
  return(df)
}

out=lakeTemp2(dir="data/", depth=0)
