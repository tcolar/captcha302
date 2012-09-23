//
// History:
//   Sep 18, 2012 tcolar Creation
//
using graphics302

**
** CaptchaWriter
** Interface for captcha image writer impl.
**
mixin CaptchaWriter
{
  ** Which chars are used by the writer to make captcha images
  abstract Int[] chars
  
  ** Returns the implementation options
  abstract Str:Obj options
  
  ** Get a new captcha code  conforming to this writer spec
  abstract CaptchaCode randomCode()
  
  ** create a captcha image for the given code
  abstract Image302 create(CaptchaCode code)  

}