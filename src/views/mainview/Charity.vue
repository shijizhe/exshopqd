<template>
<div>
  <el-card class="box-card;" shadow="always" style="width: 80%">
    <template #header>
      <div class="card-header" style="text-align: left">
        <span>置顶专区</span>
      </div>
    </template>
    伸出您的双手,帮助有需要的人。雅易相信，光是存在的!
    <el-divider><i class="el-icon-star-on"></i></el-divider>
    <el-collapse style="text-align: left">
      <div v-for="(item,index) in topdata">
        <el-collapse-item :title="item.chName" :name="item.chName">
          <div>{{item.chContent}}</div>
          <div><i class="el-icon-phone-outline"></i>联系方式:{{item.chPhone}} </div>
        </el-collapse-item>
      </div>

    </el-collapse>

  </el-card>
  <el-card class="box-card;" shadow="always" style="width: 80%;margin-top: 20px">
    <template #header>
      <div class="card-header" style="text-align: left">
        <span>其他志愿</span>
      </div>
    </template>
    <el-collapse style="text-align: left">
      <div v-for="(item,index) in otherdata">
        <el-collapse-item :title="item.chName" :name="item.chName">
          <div>{{item.chContent}}</div>
          <div><i class="el-icon-phone-outline"></i>联系方式:{{item.chPhone}} </div>
        </el-collapse-item>
      </div>
    </el-collapse>
  </el-card>
</div>
</template>
<script>
import Iconhelper from "../../components/common/iconhelper";
import {request} from "../../network/request";
import {ElMessage} from "element-plus";
export default {
  name: "Charity",
  components:{Iconhelper},
  data(){
    return{
      charitydata:[],
      topdata:[],
      otherdata:[]
    }
  },
  created() {
    this.loadCharityData();
  },
  methods:{
    loadCharityData(){
      request({url:'excharity/all',method:'get'}).then(res=>{
         this.charitydata = res.data.data
         for(let i in this.charitydata)
         {
            if(this.charitydata[i].chStatus===2)
            {
               this.topdata.push(this.charitydata[i])
            }else
            {
               this.otherdata.push(this.charitydata[i])
            }
         }
      }).catch(err=>{
        ElMessage.error("申请置顶发生错误")
      })
    }
  }
}
</script>

<style>

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>