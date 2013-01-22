//
// History:
//   Sep 19, 2012 tcolar Creation
//

**
** CaptchaCode
** The Code "password" for a generated captcha
**
@Serializable {simple = true}
const class CaptchaCode
{
  const Str val

  new makeStr(Str code)
  {
    this.val = code
  }

  Bool matches(Str text, Bool scrambledOk := false)
  {
    if( ! scrambledOk)
      return val == text.trim
    // otherwise checking if scrambled match
    if(text.size != val.size)
     return false
    Bool match := true
    cc := val.chars
    text.chars.each { match = match && cc.contains(it.upper)}
    return match
  }

  // serialization
  override Str toStr() {val}
  static CaptchaCode fromStr(Str val) {CaptchaCode.makeStr(val)}
}