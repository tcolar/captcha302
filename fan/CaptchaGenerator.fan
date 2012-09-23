//
// History:
//   Sep 18, 2012 tcolar Creation
//
using web
using graphics302

**
** CaptchaGenerator
**
class CaptchaGenerator
{
  CaptchaWriter writer
  
  new make(CaptchaWriter writer)
  {
    this.writer = writer
  }
  
  ** Create a captcha image and write it to a file
  ** Returns the captcha code value
  ** If storeInSession is true the code will automatically be stored in session["_last_captcha"]
  Str toFile(File imageFile, Bool storeInSession := true)
  {
    code := writer.randomCode
    img := writer.create(code)
    img.save(imageFile, BmpFormat())
    return code.value
  }
    
  ** Create a captcha image in memory and send it directly to the browser (commit the response)
  ** Returns the captcha code  value
  ** If storeInSession is true the code will automatically be stored in session["_last_captcha"]
  Str toBrowser(WebReq req, WebRes res, Bool storeInSession := true)
  {
    code := writer.randomCode
    img := writer.create(code)
    return code.value
  }  
  
  ** Validate the code entered by the user against the(latest) one in the session
  Bool validate(WebReq req, Str code, Str sessionKey := "_last_captcha")
  {
    req.session.get(sessionKey) == code
  }
}