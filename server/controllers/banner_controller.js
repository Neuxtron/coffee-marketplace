const fs = require("fs")

class BannerController {
  static getBanners(req, res) {
    try {
      const path = process.cwd() + "/images/banner/"
      console.log(path)
      const data = fs.readdirSync(path)

      res.status(200).json({
        status: true,
        message: "Berhasil mengambil data banner",
        data,
      })
    } catch (err) {
      console.log(err)
      res.status(500).json({
        status: false,
        message: "Terjadi kesalahan, silahkan coba lagi",
        data: {},
      })
    }
  }
}

module.exports = BannerController
