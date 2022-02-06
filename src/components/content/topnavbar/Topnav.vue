<template>
  <el-row style="height: 30px;border-bottom: #111111 2px">
    <el-col :span="6">
      <div class="el-header-by"><img src="../../../assets/image/by.png" alt=""></div>
    </el-col>
    <el-col :span="2" :offset="16" class="el-header-yh">
      <div v-if="islog === true">
        <div>

          <el-dropdown  :hide-on-click="false" style="line-height: 35px;" >
                <span class="el-dropdown-link" style="display: flex" >
                  <el-avatar
                      v-if="useravatar"
                      size="small"
                      :src="useravatar">
                  </el-avatar>
                   <el-avatar
                       v-else
                       size="small"
                       src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png">
                   </el-avatar>
                   <span style="font-size: 15px;align-self: center"><i class="el-icon-arrow-down el-icon--right"></i></span>
                </span >
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="userCenter">个人信息</el-dropdown-item>
                <el-dropdown-item @click="userPassword">修改密码</el-dropdown-item>
                <el-dropdown-item @click="userAddress">收货地址</el-dropdown-item>
                <el-dropdown-item @click="userOrder">我的订单 </el-dropdown-item>
                <el-dropdown-item @click="userCharity">我的公益 </el-dropdown-item>
                <el-dropdown-item @click="logout">退出</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
      <div v-else class="el-link-inner">
        <el-button type="text" @click="showLogdialog('login')">登录</el-button>
        <el-divider direction="vertical"></el-divider>
        <el-button type="text" @click="showLogdialog('register')">注册</el-button>
        <Logdialog :dialogflag="logvisible" @closedia="closedia" :logflag="logchoose" @linktologin="linktologin"></Logdialog>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import Logdialog from "../../common/logandre/Logdialog";
import {ElMessage} from "element-plus";

export default {
  name: "topnav",
  components: {
    Logdialog
  },
  data() {
    return {
      //查看隐藏弹窗
      logvisible: false,
      //登录弹窗选项卡
      logchoose: '',
    }
  },
  watch:{

  },
  computed:{
     islog(){
          return this.$store.state.islog
     },
     useravatar(){
          return this.$store.state.user.uavatar
     }
  },
  methods: {
    showLogdialog(value) {
      this.logvisible = true;
      this.logchoose = value;
    },
    closedia() {
      this.logvisible = false;
    },
    linktologin() {
      this.logchoose = 'login'
    },
    userCenter(){
      this.$router.push('/userhome/center')
    },
    userPassword(){
      this.$router.push('/userhome/password')
    },
    userAddress(){
      this.$router.push('/userhome/address')
    },
    userOrder(){
      this.$router.push('/userhome/myorder')
    },
    userCharity(){
      this.$router.push('/userhome/mycharity')
    },
    logout(){
      this.$router.push('/')
      this.$store.commit('setStateLogout')
      ElMessage('您已成功退出');
    }
  }
}
</script>

<style scoped>
.el-header-by {
   line-height: 30px;
}

.el-header-yh {
   line-height: 30px;
   font-size: 14px;
}
</style>