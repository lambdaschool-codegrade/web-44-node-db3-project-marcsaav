const Schemes = require('./scheme-model')
/*
  If `scheme_id` does not exist in the database:

  status 404
  {
    "message": "scheme with scheme_id <actual id> not found"
  }
*/
const checkSchemeId = async (req, res, next) => {
  try{
    const { id } = req.params
    const scheme = await Schemes.findById(id)
    if(scheme) {
      next()
    } else {
      next({ status: 404, message: `scheme with scheme_id ${id} not found`})
    }
  } catch(err) {
    next(err)
  }
}

/*
  If `scheme_name` is missing, empty string or not a string:

  status 400
  {
    "message": "invalid scheme_name"
  }
*/
const validateScheme = (req, res, next) => {
  let { scheme_name } = req.body

  if(!scheme_name || scheme_name === '' || typeof scheme_name !== 'string') {
    next({ status: 400, message: "invalid scheme_name"})
  } else {
    next()
  }
}

/*
  If `instructions` is missing, empty string or not a string, or
  if `step_number` is not a number or is smaller than one:

  status 400
  {
    "message": "invalid step"
  }
*/
const validateStep = (req, res, next) => {
  let { instructions, step_number } = req.body

  if(!instructions || instructions === '' || typeof instructions !== 'string' ) {
    next({ status: 400, message: "invalid step"})
  } else if(typeof step_number !== 'number' || step_number < 1) {
    next({ status: 400, message: "invalid step"})
  } else {
    next()
  }
}

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
}
