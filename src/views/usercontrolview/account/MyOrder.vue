<template>
  <div style="padding-left: 15px;padding-top: 15px;padding-bottom: 15px" >
    <el-row  :gutter="10">
      <el-col :span="6" >
        <el-input
            placeholder="请输入订单号查询"
            v-model="searchinput"
            clearable
            prefix-icon="el-icon-search"
        >
        </el-input>
      </el-col >
    </el-row>
    <div style="padding-top: 30px;padding-right: 15px">
      <el-table
          :data="orderdata.slice((currentPage-1)*pageSize,currentPage*pageSize)
                            .filter(data => !searchinput || data.orNo.toLowerCase().includes(searchinput.toLowerCase()))"
          :default-sort = "{prop: 'orUpdatetime', order: 'descending'}"
          style="width: 100%">
        <el-table-column type="expand">
          <template #default="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="订单号">
                <span>{{ props.row.orNo }}</span>
              </el-form-item>
              <el-form-item label="商品名称">
                <span>{{ props.row.orGoodsName }}</span>
              </el-form-item>
              <el-form-item label="商品数量">
                <span>{{ props.row.orGoodsNum }}</span>
              </el-form-item>
              <el-form-item label="商品价格">
                <span>{{ props.row.orPrice/props.row.orGoodsNum }}</span>
              </el-form-item>
              <el-form-item label="订单价格">
                <span>{{ props.row.orPrice }}</span>
              </el-form-item>
              <el-form-item label="卖家名称">
                <span>{{ props.row.orSellerName }}</span>
              </el-form-item>
              <el-form-item label="收货地址">
                <span>{{ props.row.orAddressName }}</span>
              </el-form-item>
              <el-form-item label="收货手机">
                <span>{{ props.row.orAddressPhone }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column type="index"></el-table-column>
        <el-table-column
            prop="orNo"
            label="订单号"
            width="180">
        </el-table-column>
        <el-table-column
            prop="orGoodsName"
            label="商品名称"
            width="140">
        </el-table-column>
        <el-table-column
            prop="orPrice"
            label="订单价格"
            width="80">
        </el-table-column>

        <el-table-column
            prop="orStatus"
            label="订单状态"
            width="140">
          <template #default="scope">
            <div v-if="scope.row.orStatus===1">
              <el-tag type="" effect="dark"  size="mini" >待发货</el-tag>
            </div>
            <div v-else-if="scope.row.orStatus===3">
              <el-tag  type="warning" effect="dark"  size="mini" >运输中</el-tag>
            </div>
            <div v-else-if="scope.row.orStatus===4">
              <el-tag  type="success" effect="dark"  size="mini" >已签收</el-tag>
            </div>
            <div v-else-if="scope.row.orStatus===5">
              <el-tag  type="success" effect="dark"  size="mini" >评价完成</el-tag>
            </div>
            <div v-else>
              <el-tag  type="info" effect="dark"  size="mini" >状态码:{{scope.row.orStatus}}</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column
            prop="orExpressno"
            label="快递单号"
            sortable
            width="180">
          <template #default="scope">
            <div v-if="scope.row.orExpressno===null">
              暂无
            </div>
            <div v-else>
              <el-button
                  type="text"
                  @click="goExpress(scope.$index, scope.row)"
              >
                {{scope.row.orExpressno}}
              </el-button>
              <CheckExpress
                  :closecheckexpress="closecheckexpress"
                  :rowdata="rowdata"
                  @closeExpressDialog=closeExpressDialog
              ></CheckExpress>
            </div>
          </template>
        </el-table-column>

        <el-table-column
            prop="orUpdatetime"
            label="更新时间"
            sortable
            width="180">
        </el-table-column>

        <el-table-column label="操作">
          <template #default="scope">
            <div v-if="scope.row.orStatus===1">
              等待商家发货
            </div>
            <div v-else-if="scope.row.orStatus===3">
              <el-button
                  size="medium"
                  type="text"
                  @click="getReceived(scope.$index, scope.row)"
              >签收
              </el-button>
            </div>
            <div v-else-if="scope.row.orStatus===4">
              <el-button
                  size="medium"
                  type="text"
                  @click="goComment(scope.$index, scope.row)"
              >评价
              </el-button>
              <CommentGoods
                  :rowdata="rowdata"
                  :closecommentgoods="closecommentgoods"
                  @closeCommentDialog="closeCommentDialog"
              ></CommentGoods>
            </div>
            <div v-else-if="scope.row.orStatus===5">已评价</div>
          </template>
        </el-table-column>

      </el-table>
    </div>

    <div style="padding-top: 40px;padding-bottom: 15px">
      <el-pagination
          background
          @current-change="handleCurrentChange"
          :page-size="7"
          :total="total"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";
import CommentGoods from "../../../components/content/goods/buyercomponents/CommentGoods";
import CheckExpress from "../../../components/common/order/CheckExpress";


export default {
  name: "myorder",
  components: {CheckExpress, CommentGoods},
  data(){
    return{
      orderdata:[],
      total:0,
      currentPage:1,
      pageSize:5,
      searchinput:'',
      closecommentgoods:false,
      closecheckexpress:false,
      rowdata:{}
    }
  },
  created() {
    this.loadData()
  },
  updated() {
  },
  methods:{
     loadData(){
       request({url:'/exorder/buyer',method:'get',params:{
            uid : this.$store.state.user.uid
        }}).then(res=>{
          if(res.data.code===200)
          {
            this.orderdata = res.data.data
            this.total = this.orderdata.length
          }
        }).catch(err=>{
             ElMessage.error("加载订单信息发生错误："+err)
        })

    },
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage;
    },
    getReceived(index,row){
      request({url:'/exorder/sign',method:'put',data:{Order:row}}).then(res=>{
        if (res.data.code === 200) {
          ElMessage.success("签收成功")
          this.loadData()
        } else {
          ElMessage.info("签收失败,失败代码：" + res.data.code)
        }
      }).catch(err => {
        ElMessage.info("签收失败：" + err)
      })
    },
    goComment(index,row){
      this.rowdata = row
      this.closecommentgoods = true
    },
    closeCommentDialog(){
      this.closecommentgoods = false
      this.loadData()
    },
    goExpress(index,row){
      this.rowdata = row
      this.closecheckexpress = true
    },
    closeExpressDialog(){
      this.closecheckexpress = false
      this.loadData()
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
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label{
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
</style>