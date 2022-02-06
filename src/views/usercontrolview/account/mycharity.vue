<template>
  <div style="padding-left: 15px;padding-top: 15px;padding-bottom: 15px">
    <el-card class="box-card;" shadow="always" style="width: 83%">
      <template #header>
        <div class="card-header" style="text-align: left">
          <span>我的需求</span>
          <div>
            <el-button class="button" type="text" @click="addCharity">新增</el-button>
            <el-divider direction="vertical"></el-divider>
            <el-button class="button" type="text" @click="applyPromote">申请置顶</el-button>
            <ApplyPromote
                :charitydata="charitydata"
                @closeApplyDialog="closeApplyDialog"
                :applyshowflag="applyshowflag"></ApplyPromote>
          </div>

        </div>
      </template>
      <el-table
          :data="charitydata"
          style="width: 100%">
        <el-table-column
            prop="chName"
            label="名称"
            width="140">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.chName" v-if="editdataflag[scope.$index]"></el-input>
            <span v-else>{{scope.row.chName}}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="chContent"
            label="内容"
            width="200">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.chContent" v-if="editdataflag[scope.$index]"></el-input>
            <span v-else>{{scope.row.chContent}}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="chPhone"
            label="联系方式"
            width="120">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.chPhone" v-if="editdataflag[scope.$index]"></el-input>
            <span v-else>{{scope.row.chPhone}}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="chStatus"
            label="置顶状态"
            width="120">
          <template #default="scope">
            <el-tag effect="dark" type="" v-if="scope.row.chStatus===1" size="mini">申请中</el-tag>
            <el-tag effect="dark" type="success" v-if="scope.row.chStatus===2" size="mini">已通过</el-tag>
            <el-tag effect="dark" type="warning" v-if="scope.row.chStatus===3" size="mini">已驳回</el-tag>
          </template>
        </el-table-column>
        <el-table-column
            prop="chCreatetime"
            label="更新时间"
            width="160">
        </el-table-column>
        <el-table-column
            label="操作"
            align="center"
            width="180"
        >
          <template #default="scope">
            <el-button
                size="small"
                icon="el-icon-edit"
                v-if="!editdataflag[scope.$index]"
                @click="editCharity(scope.$index)"
            >编辑
            </el-button>
            <el-button
                size="small"
                icon="el-icon-check"
                v-else
                @click="saveCharity(scope.$index, scope.row)"
            >保存
            </el-button>
            <el-popconfirm
                confirmButtonText='好的'
                cancelButtonText='不用了'
                icon="el-icon-info"
                title="确定删除该公益信息？"
                @confirm="deleteCharity(scope.$index, scope.row)"
            >
              <template #reference>
                <el-button
                    size="small"
                    icon="el-icon-delete"
                >删除
                </el-button>
              </template>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";
import ApplyPromote from "../../../components/common/charity/ApplyPromote";

export default {
  name: "mycharity",
  components: {ApplyPromote},
  data(){
    return{
      charitydata:[],
      editdataflag:[],
      applyshowflag:false
    }
  },
  created() {
    this.loadCharityData()
  },
  methods:{
     loadCharityData(){
       request({url: '/excharity/userlist', method: 'get', params: {id: this.$store.state.user.uid}}).then(res => {
         this.charitydata = res.data.data
         for (let i in this.charitydata) {
           this.editdataflag[i] = false;      //3.2 初始化布尔数组   false：查看状态（非编辑状态）
         }
       }).catch(err => {
         ElMessage.error('发生以下错误:' + err);
       })
     },
    addCharity() {
      this.charitydata.push({})      //3.3 新增公益信息
      this.editdataflag[this.charitydata.length-1] = true
    },
    editCharity(index){
      this.editdataflag[index] = !this.editdataflag[index]
    },
    saveCharity(index,row)
    {
      this.editdataflag[index] = !this.editdataflag[index]
      row.chUserid = this.$store.state.user.uid
      request({url:'/excharity/insertorupdate',method:'put',data:{Charity:row}}).then(res=>{
        if(res.data.code===200)
        {
          this.loadCharityData()
          ElMessage.success('公益信息保存成功');
        }
      }).catch(err=>{
        ElMessage.error('发生以下错误:' + err);
      })
    },
    deleteCharity(index,row){
      this.charitydata.splice(index,1)

      if(row.chUserid) {   //说明已经保存过并插入数据库中
        request({url:'/excharity/remove',method:'get',params:{id:row.chId}}).then(res=>{
              if(res.data.code===200)
              {
                ElMessage.success("删除公益信息成功");
              }else {
                ElMessage.info("删除公益信息发生以下错误:"+res.data.message);
              }

            }
        ).catch(err=>{
          ElMessage.error('删除公益信息发生以下错误:' + err);
        })
      }

    },
    applyPromote(){
       this.applyshowflag = true
    } ,
    closeApplyDialog()
    {
      this.applyshowflag = false
      this.loadCharityData()
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