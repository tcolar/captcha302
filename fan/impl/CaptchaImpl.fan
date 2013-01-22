//
// History:
//   Sep 19, 2012 tcolar Creation
//
using graphics302
using gfx
using util

**
** A (somewhat lame) captcha writer implementation
** It is quite configurable and draws a variable number of chars with variable scales
** It also draws some lines under and over the chars to make it a bit harder to read
**
class CaptchaImpl : CaptchaWriter
{
  Int width := 300
  Int height := 100
  Range codeLength := (4 .. 4)
  Color bgColor := Color.white
  Int nbBgLines := 10
  Int nbFgLines := 10
  Int maxFgStrokeSize := 4
  Int maxBgStrokeSize := 4
  Range charStroke := (5 .. 9)
  Range charScale := (4 .. 6)

  Random r := Random.makeSecure

  new make(|This|? f) {if(f!=null) f(this)}

  override Str:Obj options :=
  [
    "width" : width,
    "height" : height,
    "codeLength" : codeLength,
    "bgColor" : bgColor,
    "nbBgLines" : nbBgLines,
    "nbFgLines" : nbFgLines,
    "maxFgStrokeSize" : maxFgStrokeSize,
    "maxBgStrokeSize" : maxBgStrokeSize,
    "charStroke" : charStroke,
    "charScale" : charScale
  ]

  override CaptchaCode randomCode()
  {
    Str code := ""
    length := r.next(codeLength)
    (0 ..< length).each
    {
      c := chars[r.next((0 ..< chars.size))]
      code += c.toChar
    }
    return CaptchaCode.makeStr(code)
  }

  override Image302 create(CaptchaCode code)
  {
    img := Image302(Size(width, height))

    // fill background
    img.fill(bgColor)
    img.filledRect(Rect(0, 0, width, height))

    // add some background junk
    (0 .. nbBgLines).each
    {
      img.stroke(randomColor, r.next(1 .. maxBgStrokeSize))
      img.line(Line(next % width, next % height, next % width, next % height))
    }

    // draw the letters
    Color[] colors := [bgColor]
    nbChars := code.val.size
    code.val.chars.each |c, index|
    {
      color := uniqueColor(colors)
      colors.add(color)
      img.stroke(color, r.next(charStroke))
      x := width / nbChars * index + r.next % (width / nbChars  / 2)
      if(x < 0) x = 1
      y := r.next((0 .. height / 2))
      scale := r.next(charScale)
      charLines[c].each |line|
      {
        img.line(Line(
          x + line.x1 * scale,
          y + line.y1 * scale,
          x + line.x2 * scale,
          y + line.y2 * scale
        ))
      }
    }

    // add some foreground junk
    (0 .. nbFgLines).each
    {
      img.stroke(colors[r.next % colors.size], r.next(1 .. maxFgStrokeSize))
      img.line(Line(next % width, next % height, next % width, next % height))
    }

    return img
  }

  Int next()
  {
    return r.next.abs
  }

  Color randomColor(Int alpha := 255)
  {
    Color.makeArgb(alpha, next % 256, next % 256, next % 256)
  }

  ** get a random color that is not too much like another
  Color uniqueColor(Color[] curColors, Int alpha := 200)
  {
    while(true)
    {
      c := randomColor(alpha)
      ok := true
      curColors.each
      {
        if((it.r - c.r)<25 && (it.g - c.g)<25 && (it.b - c.b)<25)
          ok = false
      }
      if(ok)
       return c
    }
    return Color.red
  }


  ** Avoiding characters that are look  alike like i, l, 1, 0, o etc ..
  override Int[] chars := "ACDEFGHJKLNPRTXY346".chars

  static const Int:Line[] charLines :=
  [
    'A' : [Line(4, 0, 0, 8), Line(4, 0, 8, 8), Line(2, 4, 6, 4)],
    'C' : [Line(0, 0, 8, 0), Line(0, 0, 0, 8), Line(0, 8, 8, 8)],
    'D' : [Line(0, 0, 8, 0), Line(3, 0, 3, 8), Line(0, 8, 8, 8), Line(8, 0, 8, 8)],
    'E' : [Line(0, 0, 6, 0), Line(0, 4, 6, 4), Line(0, 8, 6, 8), Line(0, 0, 0, 8)],
    'F' : [Line(0, 0, 6, 0), Line(0, 3, 6, 3), Line(0, 0, 0, 8)],
    'G' : [Line(0, 0, 6, 0), Line(6,0,6,2), Line(0, 0, 0, 8),Line(0, 8, 6, 8),Line(6, 8, 6, 5),Line(4,5,8,5)],
    'H' : [Line(8, 0, 8, 8), Line(0, 4, 8, 4), Line(0, 0, 0, 8)],
    'J' : [Line(1, 0, 7, 0), Line(4, 0, 4, 8), Line(1, 8, 4, 8), Line(1, 8, 1, 6)],
    'K' : [Line(0, 4, 6, 0), Line(0, 4, 6, 8), Line(0, 0, 0, 8)],
    'L' : [Line(2, 0, 2, 8), Line(2, 8, 6, 8)],
    'N' : [Line(0, 0, 6, 8), Line(6, 0, 6, 8), Line(0, 0, 0, 8)],
    'P' : [Line(0,0,0,8), Line(0, 0, 6, 0), Line(6, 0, 6, 3), Line(0, 3, 6, 3)],
    'R' : [Line(0,0,0,8), Line(0, 0, 6, 0), Line(6, 0, 6, 3), Line(0, 3, 6, 3), Line(0, 3, 6, 8)],
    'T' : [Line(0, 0, 8, 0), Line(4, 0, 4, 8)],
    'X' : [Line(0, 0, 8, 8), Line(0, 8, 8, 0)],
    'Y' : [Line(0, 0, 4, 4), Line(4, 4, 8, 0), Line(4, 4, 4, 8)],
    '3' : [Line(0, 8, 8, 8),Line(0, 4, 8, 4), Line(0, 0, 8, 0), Line(8, 0, 8, 8)],
    '4' : [Line(1, 0, 0, 4), Line(0, 4, 8, 4), Line(5, 2, 5, 8)],
    '6' : [Line(0, 0, 0, 8), Line(0, 0, 6, 0), Line(0, 4, 6, 4),Line(0, 8, 6, 8),Line(6, 4, 6, 8)],
  ]
}

