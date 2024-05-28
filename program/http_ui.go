package program

import (
	"log"
	"mime"
	"net/http"
	"path"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/shinxiang/etcd-manage/etcd-manage-ui/tpls"
)

// ui 界面
// 处理静态文件
func (p *Program) handlerStatic(c *gin.Context) {
	uri := strings.TrimLeft(c.Request.RequestURI, "/")
	uri = strings.TrimRight(uri, "?")
	log.Println(uri)
	if uri == "ui/" || uri == "ui" {
		uri = "dist/index.html"
	} else {
		uri = strings.Replace(uri, "ui", "dist", 1)
	}
	// log.Println(uri)
	// 读取模版内容
	body, err := tpls.Asset(uri)
	if err != nil {
		log.Println("UI static file reading error", "err", err)
		c.Status(http.StatusNotFound)
		return
	}
	mimetype := mime.TypeByExtension(path.Ext(uri))
	if mimetype != "" {
		c.Header("Content-Type", mimetype)
	}

	c.Writer.Write(body)
}
