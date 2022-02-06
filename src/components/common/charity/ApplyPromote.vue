<template>
  <el-dialog
      title="申请置顶"
      width="40%"
      v-model="applyshowflag"
      :close-on-click-modal="false"
      :before-close="closeApplyDialog"
      :destroy-on-close="true"
  >
    雅易会最快速度筛选您的申请。汇聚点滴星光，助您点亮浩瀚星河！
    <el-divider><i class="el-icon-star-on"></i></el-divider>
    <el-form
        ref="applyadta"
        :model="applyadta"
    >
      <el-form-item label="请选择要申请的项目" prop="chId">
        <el-select
            v-model="applyadta.chId"
            placeholder="请选择">
          <el-option
              v-for="item in charitydata"
              :key="item.chId"
              :label="item.chName"
              :value="item.chId">
          </el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
    <span class="dialog-footer">
      <el-button @click="closeApplyDialog">取 消</el-button>
      <el-button type="primary" @click="applyForPromote" >申 请</el-button>
    </span>
    </template>
  </el-dialog>
</template>

<script>
import {request} from "@/network/request";
import {ElMessage} from "element-plus";

export default {
  name: "ApplyPromote",
  data(){
    return{
       applyadta:{}
    }
  },
  props:{
    applyshowflag:Boolean,
    charitydata:Array
  },
  emits:['closeApplyDialog'],
  methods:{
    closeApplyDialog()
    {
      this.applyadta = {}
      this.$emit('closeApplyDialog')
    },
    applyForPromote(){
      request({url:'excharity/singleapply',method:'get',params:{id:this.applyadta.chId}}).then(res=>{
          ElMessage.success("申请置顶成功，请关注后续置顶情况")
          this.closeApplyDialog()
      }).catch(err=>{
         ElMessage.error("申请置顶发生错误")
      })
    }
  }
}
</script>

<style scoped>

</style>