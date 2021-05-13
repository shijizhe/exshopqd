<template>
  <div style="padding: 30px;">
    <el-card class="box-card;" shadow="always" style="width: 93%">
      <template #header>
        <div class="card-header" style="text-align: left">
          <span>管理地址</span>
          <el-button class="button" type="text" @click="addAddress">新增</el-button>
        </div>
      </template>
      <el-table :data="addressData">
        <el-table-column type="index"></el-table-column>
        <el-table-column
            prop="adname"
            label="收货人"
            width="100">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.adname" v-if="addressEdit[scope.$index]"></el-input>
            <span v-else>{{scope.row.adname}}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="adphone"
            label="联系方式"
            width="140">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.adphone" v-if="addressEdit[scope.$index]"></el-input>
            <span v-else>{{scope.row.adphone}}</span>
          </template>
        </el-table-column>


        <el-table-column
            prop="adpca"
            label="收货地址"
            width="240"
            align="center"
        >
          <template #default="scope">
            <el-cascader
                v-model="scope.row.adpca"
                :options="pcaOptions"
                :props="addressProps"
                ref="cascaderAddr"
                placeholder="请选择"
                @change="handleAddressNode($event,scope.row)"
                filterable
                :disabled="!addressEdit[scope.$index]"
            ></el-cascader>
          </template>
        </el-table-column>


        <el-table-column
            prop="addetail"
            label="详细地址"
            width="180">
          <template #default="scope">
            <el-input size="medium" v-model="scope.row.addetail" v-if="addressEdit[scope.$index]"></el-input>
            <span v-else>{{scope.row.addetail}}</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="adisdefault"
            label="默认地址"
            width="100">
          <template #default="scope">
            <div v-if="addressEdit[scope.$index]">
              <el-switch
                  v-model="scope.row.adisdefault"
                  :active-value = "1"
                  :inactive-value = "0"
              ></el-switch>

            </div>
            <div v-else>
              <el-tag  v-if="scope.row.adisdefault===1" type="success" size="mini" >默认</el-tag>
            </div>
          </template>
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
                v-if="!addressEdit[scope.$index]"
                @click="editAddress(scope.$index)"
            >编辑
            </el-button>
            <el-button
                size="small"
                icon="el-icon-check"
                v-else
                @click="saveAddress(scope.$index, scope.row)"
            >保存
            </el-button>
            <el-popconfirm
                confirmButtonText='好的'
                cancelButtonText='不用了'
                icon="el-icon-info"
                title="确定删除该地址？"
                @confirm="deleteAddress(scope.$index, scope.row)"
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

const pca = require('../../../assets/adress/pca-code.json')

export default {
  name: "Useraddress",
  data() {
    return {
      addressData: [], //table绑定表格数据
      addressEdit: [], //用于动态修改行内数据
      pcaOptions:pca,
      addressProps:{
        label: 'name',
        children: 'children',
        value: 'code'
      }
    }
  },
  props : {

  },
  created() {
    this.loadAddressData()
  },
  methods: {
    loadAddressData() {
      request({url: '/address/useraddress', method: 'get', params: {userid: this.$store.state.user.uid}}).then(res => {
        this.addressData = res.data.data
        for (let i in this.addressData) {
          this.addressEdit[i] = false;      //3.2 初始化布尔数组   false：查看状态（非编辑状态）
        }
      }).catch(err => {
        ElMessage.error('发生以下错误:' + err);
      })
    },
    addAddress() {
      this.addressData.push({})      //3.3 新增地址
      this.addressEdit[this.addressData.length-1] = true
    },
    editAddress(index){
      this.addressEdit[index] = !this.addressEdit[index]
    },
    saveAddress(index,row)
    {
      this.addressEdit[index] = !this.addressEdit[index]
      row.aduserid = this.$store.state.user.uid
      request({url:'/address/insertorupdate',method:'put',data:{Address:row}}).then(res=>{
        if(res.data.code===200)
        {
          this.loadAddressData()
          ElMessage.success('地址保存成功');
        }
      }).catch(err=>{
        ElMessage.error('发生以下错误:' + err);
      })
    },
    deleteAddress(index,row){
      this.addressData.splice(index,1)

      if(row.aduserid) {   //说明已经保存过并插入数据库中
        request({url:'/address/remove',method:'get',params:{id:row.adid}}).then(res=>{
              if(res.data.code===200)
              {
                ElMessage.success("删除地址成功");
              }else {
                ElMessage.info("删除地址发生以下错误:"+res.data.message);
              }

            }
        ).catch(err=>{
          ElMessage.error('删除地址发生以下错误:' + err);
        })
      }

    },
    handleAddressNode(value,row){
      row.adpca = value[2]   //三级级联地址，只需要把第三级存入数据库即可
      let theAreaCode = this.$refs['cascaderAddr'].getCheckedNodes()[0].pathLabels
      row.adprovince = theAreaCode[0]
      row.adcity = theAreaCode[1]
      row.adcounty = theAreaCode[2]
    },
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