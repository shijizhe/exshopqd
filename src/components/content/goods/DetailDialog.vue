<template>
  <!-- 首页商品详情页-->
<div>
  <el-dialog
      title="商品详情"
      width="50%"
      v-model="closedetail"
      :close-on-click-modal="false"
      :before-close="closeDetailDialog"
      :destroy-on-close="true"
  >
    <el-descriptions style="font-size: 15px" >
      <el-descriptions-item label="商品名称:" span="3">{{goodsinfo.gname}}</el-descriptions-item>
      <el-descriptions-item label="卖家:">{{goodsinfo.gowner}}</el-descriptions-item>
      <el-descriptions-item label="商品价格:">{{goodsinfo.gprice}}</el-descriptions-item>
      <el-descriptions-item label="更新时间:">{{goodsinfo.gupdatetime}}</el-descriptions-item>
      <el-descriptions-item label="商品描述:" span="3">{{goodsinfo.gdetail}}</el-descriptions-item>
      <el-descriptions-item label="商品图片:" span="3" style="line-height: 172px">
        <img v-if="goodsinfo.gcover" :src="goodsinfo.gcover" alt="封面">
        <img v-else src="https://i.loli.net/2019/04/10/5cada7e73d601.jpg" alt="封面">
      </el-descriptions-item>
    </el-descriptions>

    <template #footer>
    <span class="dialog-footer">
      <el-button @click="reportHarmfulGoods" icon="el-icon-warning-outline">举 报</el-button>
      <el-button @click="openOrderDialog" icon="el-icon-sold-out">购 买</el-button>
    </span>
    </template>
  </el-dialog>

</div>
</template>

<script>
import OrderDialog from "./OrderDialog";
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";
export default {
  name: "DetailDialog",
  components: {OrderDialog},
  date(){
    return{

    }
  },
  props:{
    closeorder:Boolean,
    closedetail:Boolean,
    goodsinfo:Object
  },
  emits:['closeDetailDialog','showOrderDialog'],
  methods:{
    closeDetailDialog(){
       this.$emit('closeDetailDialog')
    },
    openOrderDialog(){
      this.$emit('closeDetailDialog')
      this.$emit('showOrderDialog')
    },
    reportHarmfulGoods(){
      request({url:'/harminfo/create',method:'get',params:{
          goodsid:this.goodsinfo.gid,
          userid:this.goodsinfo.gownerid
        }}).then(res=>{
        if(res.data.code===200)
        {
          ElMessage.success("已收到您的举报信息，感谢您为维护平台纯净所做的贡献~")
          this.closeDetailDialog()
        }
      }).catch(err=>{
        ElMessage.error("举报商品发生以下问题："+err);
      })
    }



  }
}
</script>

<style scoped>
img {
  width: 115px;
  height: 172px;
  /*margin: 0 auto;*/
}

</style>