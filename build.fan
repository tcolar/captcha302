using build

**
** Build
**
class Build : BuildPod
{
  new make()
  {
    podName = "captcha302"
    summary = "Captcha implementation. In memory graphics, doesn't use FWT / SWT at all."
    meta = ["vcs.uri":"https://bitbucket.org/status302/captcha302/",
      "license.name":"MIT"]
    depends = ["sys 1.0+", "web 1.0+", "gfx 1.0+", "graphics302 0.0.1+", "util 1.0+"]
    srcDirs = [`fan/`, `fan/impl/`]
    resDirs = [,]
    version = Version("1.0.0")
  }
}