module.exports = 
  requiresLogin: (req, res, next)->
    if req.isAuthenticated()
      return next()

    res.status(403).json({message: "Please login"})
