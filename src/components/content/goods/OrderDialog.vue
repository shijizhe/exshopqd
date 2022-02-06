<template>
  <!-- 下单，生成订单页-->
  <el-dialog
      title="商品下单"
      width="50%"
      v-model="closeorder"
      :close-on-click-modal="false"
      :before-close="closeOrderDialog"
      :destroy-on-close="true"
      style="text-align: left;line-height: 80px"
  >
    <el-card>
      <el-steps :active="active" finish-status="success" align-center>
        <el-step title="选择地址"></el-step>
        <el-step title="支付信息"></el-step>
        <el-step title="创建订单"></el-step>
      </el-steps>
      <el-divider></el-divider>
      <div v-if="active===0" style="text-align: left;padding-left: 50px;">
        <el-container>
          <div v-if="addressdata.length===0">
            <el-alert
                title="您的账户中暂无地址信息，请点击下方的管理地址前往创建"
                type="warning"
                :closable = "false"
            >
            </el-alert>
            <el-button type="text" @click="goEditAddress" style="margin-top: 20px;margin-left: 50px">管理地址</el-button>
          </div>
          <div v-else>
            <el-container>
              <el-aside width="100px">
                <el-space direction="vertical">
                  <el-radio v-model="addressradio" label="1" style="line-height: 50px" :disabled="addressradiostate[0]">
                    默认地址
                  </el-radio>
                  <el-radio v-model="addressradio" label="2" style="line-height: 50px" :disabled="addressradiostate[1]">
                    其他地址
                  </el-radio>
                  <el-button type="text" @click="goEditAddress">管理地址</el-button>
                </el-space>
              </el-aside>
              <el-main>
                <div style="line-height: 50px;">
                  <div>
                    <div v-if="defaultAddress.length===0">
                      暂无默认地址，请前往地址中心设置
                    </div>
                    <div v-else style="width: 500px;line-height: 30px;">
                      <el-descriptions>
                        <el-descriptions-item label="地址:" span="3">
                          {{ defaultAddress.adprovince+'/' + defaultAddress.adcity +'/'+ defaultAddress.adcounty+'  '+ defaultAddress.addetail}}
                        </el-descriptions-item>
                        <el-descriptions-item label="收货人:">
                          {{defaultAddress.adname}}
                        </el-descriptions-item>
                        <el-descriptions-item label="手机号:">
                          {{defaultAddress.adphone}}
                        </el-descriptions-item>
                      </el-descriptions>
                    </div>
                  </div>
                  <div style="line-height: 50px;width: 400px">
                    <el-select v-model="targetAddress" placeholder="选择其他地址" style="width: 400px">
                      <el-option
                          v-for="item in otherAddress"
                          :key="item.adid"
                          :label="item.adprovince +'/'+ item.adcity+'/' + item.adcounty+'  '+ item.addetail+'  '+item.adname+'  '+item.adphone"
                          :value="item.adid">
                      </el-option>
                    </el-select>
                  </div>
                </div>
              </el-main>
            </el-container>
          </div>
        </el-container>
      </div>

      <div v-if="active===1" style="text-align: left;padding-left: 50px;">
        <el-space direction="vertical">
           <div> 商品价格: {{ goodsinfo.gprice}}</div>
           <div> 购买数量:<el-input-number v-model="orderForm.orGoodsNum" controls-position="right" :min="1"></el-input-number> </div>
        </el-space>
      </div>
      <div v-if="active===2">
        <div v-if="orderResult">
          <el-result icon="success" title="下单成功" subTitle="您可以去订单中心查看详细信息">
            <template #extra>
              <el-space direction="vertical">
                <div>订单号:{{orderResult}}</div>
                <el-button type="text" size="medium" @click="goOrderCenter">订单中心</el-button>
                <el-button type="primary" size="medium" @click="goHome">返回首页</el-button>
              </el-space>
            </template>
          </el-result>
        </div>
        <div v-else>
          <el-button @click="hangdleOrder">下 单</el-button>
        </div>
      </div>
    </el-card>
    <template #footer>
      <el-button @click="preStep" :disabled="buttonstatus[0]">上一步</el-button>
      <el-button @click="nextStep" :disabled="buttonstatus[1]">下一步</el-button>
    </template>
  </el-dialog>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "OrderDialog",
  components: {},
  data() {
    return {
      active: 0,
      buttonstatus: [true, false],
      addressradio: '1',
      addressradiostate:[false,false],
      addressdata: [],
      defaultAddress: [],
      otherAddress: [],
      targetAddress:'',
      orderForm: {
          orGoodsNum : 1
        },
      orderResult:null
    }
  },
  props: {
    closeorder: Boolean,
    goodsinfo: Object
  },
  watch: {
    active(newValue, oldValue) {
      if (newValue === 0) {
        this.buttonstatus = [true, false]
      } else if (newValue === 2) {
        this.buttonstatus = [false, true]
      } else {
        this.buttonstatus = [false, false]
      }
    },
    userid(newVal,oldVal){
       this.loadAddressData()
    }
  },
  emits: ['closeOrderDialog'],
  created() {
    this.loadAddressData()
  },
  computed:{
    userid(){
      return this.$store.state.user.uid
    }
  },
  methods: {
    closeOrderDialog() {
      this.$emit('closeOrderDialog')
      this.active = 0
      this.buttonstatus = [true, false]
      this.addressradiostate = [false,false]
      this.orderResult = null
      this.targetAddress = []
      this.defaultAddress = []
      this.otherAddress = []
    },
    preStep() {
      this.active--
    },
    nextStep() {
      this.active++
    },
    loadAddressData() {
      this.addressradiostate=[false,false]
      request({url: '/address/useraddress', method: 'get', params: {userid: this.userid}}).then(res => {
        this.addressdata = res.data.data
        for (let i in this.addressdata) {
          if (this.addressdata[i].adisdefault === 1) {
            this.defaultAddress = this.addressdata[i]
          } else {
            this.otherAddress.push(this.addressdata[i])
          }
        }
        if(this.otherAddress.length===0)
        {
            this.addressradiostate[1] = true
        }
        if(this.defaultAddress.length===0)
        {
            this.addressradiostate[0] = true
        }
      }).catch(err => {
        ElMessage.error('发生以下错误:' + err);
      })
    },
    goEditAddress(){
      this.$router.push('/userhome/address')
    },
    loadOrderData(){
      //load goods information in order
      this.orderForm.orGoodsId = this.goodsinfo.gid
      this.orderForm.orSellerId = this.goodsinfo.gownerid
    },
    hangdleOrder(){
      this.loadOrderData()
      this.orderForm.orStatus = 1
      this.orderForm.orBuyerId = this.$store.state.user.uid
      this.orderForm.orPrice = this.goodsinfo.gprice*this.orderForm.orGoodsNum
      console.log(""+this.addressradio);
      console.log(typeof(this.addressradio))
      console.log(this.targetAddress)
      if(this.addressradio==='1')
      {
        this.orderForm.orAdressId = this.defaultAddress.adid
      }else{
        this.orderForm.orAdressId =this.targetAddress
      }

      request({url:'/exorder/create',method:'put',data:{
          Order:this.orderForm
        }}).then(res=>{
          if(res.data.code===200)
          {
            this.orderResult =  res.data.data
          }
      }).catch(err=>{
          ElMessage.error("生成订单发生以下问题："+err);
      })
    },
    goOrderCenter(){
      this.closeOrderDialog()
      this.$router.push('/userhome/myorder')
    },
    goHome(){
      this.closeOrderDialog()
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>

</style>