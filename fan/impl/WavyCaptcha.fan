//
// History:
//   Sep 19, 2012 tcolar Creation
//
using graphics302
using gfx

**
** WavyCaptcha
**
class WavyCaptcha : CaptchaWriter
{
  override Int[] chars := ['T','O','D','O']
  
  override Str:Obj options := [:]
  
  override CaptchaCode randomCode()
  {
    return CaptchaCode("Todo")
  }
  
  override Image302 create(CaptchaCode code)
  {
    img := Image302(Size(300, 200))
    return img
  }  
}