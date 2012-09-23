//
// History:
//   Sep 19, 2012 tcolar Creation
//

**
** CaptchaCode
**
@Serializable{simple=true}
const class CaptchaCode
{
  const Str code
  
  new make(Str code)
  {
    this.code = code
  }
  
  Str value() {code.toStr}
  
  override Str toStr() {value}
}