//
// History:
//   Sep 18, 2012 tcolar Creation
//
using web
using graphics302

**
** CaptchaGenerator
** Generate Capctha code/image to file or directly to the browser
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
  ** If storeInSession is true the code will automatically be stored in session["_last_captcha302"]
  CaptchaCode toFile(File imageFile, ImageFormat format := BmpFormat())
  {
    code := writer.randomCode
    img := writer.create(code)
    img.save(imageFile, format)
    return code
  }

  ** Create a captcha image in memory and send it directly to the browser (commit the response)
  ** Returns the captcha code value
  ** If storeInSession is true the code will automatically be stored in session["_last_captcha302"]
  CaptchaCode toBrowser(WebReq req, WebRes res,
                        ImageFormat format := BmpFormat(), Bool storeInSession := true)
  {
    code := writer.randomCode
    img := writer.create(code)
    res.statusCode = 200
    res.headers["Content-Type"] = format.contentType
    out := res.out
    try
    {
      format.save(out, img)
      if(storeInSession)
        req.session["_last_captcha302"] = code
    } catch(Err e) {e.trace}
    finally{out.close}
    return code
  }

  ** Validate the code entered by the user against the(latest) one in the session
  ** If scrambledOk is true then the letters order does not have to match
  Bool validate(WebReq req, Str code, Bool scrambledOk := false, Str sessionKey := "_last_captcha302")
  {
    cc := req.session.get(sessionKey) as CaptchaCode
    return  cc == null ? false  : cc.matches(code, scrambledOk)
  }
}