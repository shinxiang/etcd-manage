package etcdsdk

import (
	"github.com/shinxiang/etcd-manage/etcdsdk/etcdv2"
	"github.com/shinxiang/etcd-manage/etcdsdk/etcdv3"
	"github.com/shinxiang/etcd-manage/etcdsdk/model"
)

/*
 golang 操作etcd sdk，可以兼容v2和v3版本etcd api
*/

// NewClientByConfig 创建一个etcd客户端
// 可重复调用，不会重复和etcd建立连接
func NewClientByConfig(cfgObj *model.Config) (client model.EtcdSdk, err error) {
	if cfgObj == nil {
		err = model.ERR_CONFIG_ISNIL
		return
	}
	if cfgObj.Version == model.ETCD_VERSION_V2 {
		client, err = etcdv2.NewClient(cfgObj)
	} else if cfgObj.Version == model.ETCD_VERSION_V3 {
		client, err = etcdv3.NewClient(cfgObj)
	} else {
		err = model.ERR_UNSUPPORTED_VERSION
	}
	return
}
