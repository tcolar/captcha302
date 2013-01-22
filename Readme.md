### What is this:

This is a Captha generator for Fantom. (Completely Automated Public Turing test to tell Computers and Humans Apart")

It doesn't use FWT / SWT at all but creates the images in memory
using [graphics302](https://bitbucket.org/status302/graphics302/).

The default captcha writer implementation can be configured quite a bit, see CaptchaImpl.fan, or you could make your own.

### Usage:

Here is how to send a capctha diectly to the browser (BMP image):

    // sending a captcha image to the browser
    CaptchaGenerator g := CaptchaGenerator(CaptchaImpl{})
    g.toBrowser(req, res)

And later you can check the user entry with something like this:

    ok := g.validate(req, req.form["captcha"]))

You could also save a captcha to file like this:

    g := CaptchaGenerator(CaptchaImpl{})
    code := g.toFile(`/tmp/file.bmp`)
    echo("code: $code.val")

Here is an example of what it might look like:

![captcha example](https://bitbucket.org/status302/captcha302/raw/tip/captcha.bmp)

Yeah I know, it's not beautiful :)






