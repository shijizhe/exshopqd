<template>
  <el-dialog
      title="快递信息"
      width="50%"
      v-model="closecheckexpress"
      :before-close="closeExpressDialog"
      :destroy-on-close="true"
  >
    <el-descriptions>
      <el-descriptions-item label="快递公司:" span="3">
        <el-radio-group v-model="rowdata.orExpresstype" disabled>
          <el-radio label="HTKY">百世快递</el-radio>
          <el-radio label="STO">申通快递</el-radio>
          <el-radio label="YTO">圆通速递</el-radio>
          <el-radio label="HHTT">天天快递</el-radio>
        </el-radio-group>
      </el-descriptions-item>
      <el-descriptions-item label="快递单号:" span="3">
        {{rowdata.orExpressno}}
      </el-descriptions-item>
    </el-descriptions>
    <el-card class="box-card;" shadow="always" style="width: 100%">
      <template #header>
        <div class="card-header" style="text-align: left">
          <span>物流信息</span>
          <el-button class="button" type="text" @click="loadExpressData">查 询</el-button>

        </div>
      </template>
      <el-timeline>
        <el-timeline-item
            v-for="(trace, index) in expresstrace"
            :key="index"
            :timestamp="trace.AcceptTime">
          {{trace.AcceptStation}}
        </el-timeline-item>
      </el-timeline>
    </el-card>

  </el-dialog>
</template>

<script>
import {request} from "@/network/request";
import {ElMessage} from "element-plus";

export default {
  name: "CheckExpress",
  data(){
    return{
       expressResult:{},
       expresstrace:[]
    }
  },
  props:{
    closecheckexpress:Boolean,
    rowdata:Object
  },
  emits:['closeExpressDialog'],
  created() {
  },
  mounted() {
  },
  methods:{
    loadExpressData(){
      request({url:'/express/info',method:'get',params:{
          type: this.rowdata.orExpresstype,
          no: this.rowdata.orExpressno
        }}).then(res=>{
        if (res.data.data.Success === true) {
            this.expresstrace = res.data.data.Traces
        } else {
          ElMessage.info("加载物流信息失败,失败代码：" + res.data.code)
        }
      }).catch(err => {
        ElMessage.info("加载物流信息失败失败：" + err)
      })
    },
    closeExpressDialog() {
      this.expresstrace = []
      this.expressResult = {}
      this.$emit('closeExpressDialog')
    },
    handleGoodsData(){
      this.orderdata = this.rowdata
      this.orderdata.cmReply = this.applyform.cmReply
      request({url:'/exorder/apply',method:'put',data:{Order:this.orderdata}}).then(res=>{
        if (res.data.code === 200) {
          ElMessage.success("回复成功")
          this.closeExpressDialog()
        } else {
          ElMessage.info("回复失败,失败代码：" + res.data.code)
        }
      }).catch(err => {
        ElMessage.info("回复失败：" + err)
      })
    }
  }
}
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>