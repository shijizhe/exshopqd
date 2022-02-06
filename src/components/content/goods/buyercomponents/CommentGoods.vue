<template>
  <el-dialog
      title="评价商品"
      width="40%"
      v-model="closecommentgoods"
      :close-on-click-modal="false"
      :before-close="closeCommentDialog"
      :destroy-on-close="true"
  >
    <el-form
        ref="commentform"
        :model="commentform"
        label-width="80px"
    >
      <el-form-item label="评分" prop="cmStar">
        <el-rate
            v-model="commentform.cmStar"
            :colors="colors"
            show-text
            :texts="['极差', '失望', '一般', '满意', '惊喜']"
            style="padding-top: 10px;padding-left: 20px"
        >
        </el-rate>
      </el-form-item>
      <el-form-item label="描述" prop="cmContent">
        <el-input
            v-model="commentform.cmContent" type="textarea"
            maxlength="150"
            placeholder="已经入手了一段时间了吧，说说你的感受吧~"
        ></el-input>
      </el-form-item>
    </el-form>
    <template #footer>
    <span class="dialog-footer">
      <el-button @click="closeCommentDialog">取 消</el-button>
      <el-button type="primary" @click="handleGoodsComment">评 价</el-button>
    </span>
    </template>
  </el-dialog>
</template>

<script>
import {request} from "@/network/request";
import {ElMessage} from "element-plus";

export default {
  name: "CommentGoods",
  data(){
    return{
      commentform:{},
      orderdata:{},
      colors: ['#99A9BF', '#F7BA2A', '#fc788f']
    }
  },
  props:{
    closecommentgoods:Boolean,
    rowdata:Object
  },
  emits:['closeCommentDialog'],
  methods:{
    closeCommentDialog() {
      this.orderdata = {}
      this.$refs["commentform"].resetFields();
      this.$emit('closeCommentDialog')
    },
    handleGoodsComment(){
      this.orderdata = this.rowdata
      this.orderdata.cmStar = this.commentform.cmStar
      this.orderdata.cmContent = this.commentform.cmContent
      request({url:'/exorder/comment',method:'put',data:{
          Order:this.rowdata
      }}).then(res=>{
        if (res.data.code === 200) {
          ElMessage.success("评价成功")
          this.closeCommentDialog()
        } else {
          ElMessage.info("评价失败,失败代码：" + res.data.code)
        }
      }).catch(err => {
        ElMessage.info("评价失败：" + err)
      })
    }
  }
}
</script>

<style scoped>

</style>