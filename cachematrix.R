## Lexical Scoping
## Create matrix: 
## m <- makeCacheMatrix(matrix(c(1:4),nrow=2,ncol=2))

## Create a list of functions:
## Set the matrix: m$set(matrix(c(1,2,3,4),nrow=2,ncol=2))
## Get the matrix: m$get()
## Set the matrix inverse in cache: cacheSolve(j)
## Get the matrix inverse from cache (should add "Get cache data": cacheSolve(j) 
makeCacheMatrix <- function(x = matrix()) {
    
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() {
        x
    }
    setinv <- function(solve) {
        m <<- solve
    }
    getinv <- function() {
        m
    }
    
    list(set = set, 
         get = get,
         setinv = setinv,
         getinv = getinv)
}


## If the matrix has the inverse already stored, then return it and exit loop.
## If it isn't already cached, then use solve() and cache it.
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinv()
    if(!is.null(m)) {
        message("Get cache data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinv(m)
    m
}

