<template>
  <div style="padding: 30px;">
    <el-card class="box-card;" shadow="always" style="width: 40%">
      <template #header>
        <div class="card-header" style="text-align: left">
          <span>用户中心</span>

            <span v-if="disabled"><el-button class="button" type="text" @click="editProfile">编辑</el-button></span>
            <span v-else><el-button class="button" type="text" @click="saveProfile">保存</el-button></span>

        </div>
      </template>
          <el-form
              ref="accountForm"
              :model="accountForm"
              :rules="rules"
              status-icon
              label-width="80px"
              :disabled="disabled"
          >
            <el-form-item label="用户名" prop="uname">
              <el-input v-model="accountForm.uname"> </el-input>
            </el-form-item>
            <el-form-item label="头像" prop="uavatar">
                <el-upload
                    class="avatar-uploader"
                    action="https://upload.qiniup.com"
                    :data="avatarData"
                    :show-file-list="false"
                    :on-success="handleAvatarSuccess"
                    :before-upload="beforeAvatarUpload"
                >
                  <img v-if="accountForm.uavatar" :src="accountForm.uavatar" class="avatar" alt="">
                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
            </el-form-item>
            <el-form-item label="手机号" prop="uphone">
              <el-input v-model="accountForm.uphone"> </el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="umail">
              <el-input v-model="accountForm.umail"> </el-input>
            </el-form-item>
          </el-form>
    </el-card>

  </div>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "Account",
  data(){
    let validateUser = async (rule, value, callback) => {
      if (value === '') {
        return callback(new Error('请输入用户名'))
      }else if(value === this.$store.state.user.uname)
      {
        callback()
      }
      else {
        if (value) {
          await request({url:'/user/judgename', method:'get', params:{uname:value}
          }).then(response=>{
            if (response.data.data === "hasname") {
              callback(new Error('该用户名已经被注册'))
            } else {
              callback()
            }
          }).catch(error=>
          {
            callback(new Error(error))
          })
        }
      }
    }
    let validatePhone = async (rule, value, callback) => {
      if (value === '') {
        callback(new Error('手机号不能为空'))
      }else if(value === this.$store.state.user.uphone)
      {
        callback()
      }
      else {
        const reg = /^1[3|4|5|7|8][0-9]\d{8}$/
        if (reg.test(value)) {
          await request({url:'/user/judgephone', methods:'get', params:{uphone:value}
          }).then(response=>{
            if (response.data.data === "hasphone") {
              callback(new Error('该手机号已经被注册'))
            } else {
              callback()
            }
          }).catch(error=>
          {
            callback(new Error(error))
          })
        }else {
          callback(new Error('号码格式错误'))
        }
      }
    }
    let validateMail = async (rule, value, callback) => {
      if (value === '') {
        callback()
      }else if(value === this.$store.state.user.umail)
      {
        callback()
      }
      else {
          await request({url:'/user/judgemail', methods:'get', params:{umail:value}
          }).then(response=>{
            if (response.data.data === "hasmail") {
              callback(new Error('该邮箱已经被注册'))
            } else {
              callback()
            }
          }).catch(error=>
          {
            callback(new Error(error))
          })
      }
    }
    return{
      disabled:true,
      accountForm:{
          uid:'',
          uname:'',
          uavatar:'',
          upassword: '',
          uphone:'',
          umail:'',
      },
      rules:{
         uname:[{
           required: true,
           validator: validateUser,
           trigger: 'blur'
         }],
         uphone:[{
           required: true,
           validator: validatePhone,
           trigger: 'blur'
         }],
         umail:[{
           required: true,
           validator: validateMail,
           trigger: 'blur'
         }],
         uavatar: [{
           required: false,
           trigger: 'blur'
         }]
      },
      avatarData:{
        token: '',
        key: ''
      }
    }
  },
  computed:{
  },
  created() {
    this.loadUserData()
    this.getToken()
  },
  updated() {
    this.getToken()
  },
  methods:{
    editProfile(){
      this.disabled = false
    },
    saveProfile(){
      this.$refs["accountForm"].validate((valid) => {
        if (valid) {
          this.disabled = true
          request({url: '/user/update', method: 'put', data: {User: this.accountForm}}).then(res => {
            if (res.data.code === 200) {
              ElMessage.success("更改用户信息成功")
              this.$store.commit("setStateLogin", this.accountForm)
            } else {
              ElMessage.info("更改用户信息失败,失败代码：" + res.data.code)
            }
          }).catch(err => {
            ElMessage.info("更改用户信息失败：" + err)
          })
        }
      })
    },
    loadUserData(){
       this.accountForm.uid = this.$store.state.user.uid;
       request({url:'/user/info',method:'get',params:{uid:this.accountForm.uid }}).then(res => {
         if (res.data.code === 200) {
           this.accountForm = res.data.data
         } else {
           ElMessage.info("获取用户信息失败,失败代码：" + res.data.code)
         }
       }).catch(err => {
         ElMessage.info("获取用户信息失败：" + err)
       })
    },
    async getToken() {
        await request({url: '/qiniu/token', method: 'get'}).then(res => {
        this.avatarData.token = res.data.data;
      }).catch(
          err => {
            ElMessage.info("获取token错误：" + err)
          }
      )
    },
    beforeAvatarUpload(file){
      this.getToken()  //获取token
      this.avatarData.key = 'user/avatar/' + file.name;        // 通过设置key为文件名，上传到七牛中会显示对应的图片名
      const isJPG = file.type === "image/jpeg" || file.type === "image/jpg";
      const isLt10M = file.size / 1024 / 1024 < 10;
      if (!isJPG) {
        ElMessage.error("上传头像图片只能是 JPG/JPEG 格式!");
      }
      if (!isLt10M) {
        ElMessage.error("上传头像图片大小不能超过 10MB!");
      }
      return isJPG && isLt10M
    },
    handleAvatarSuccess(res, file){
      this.accountForm.uavatar = cdnurl + res.key;
    }
  }
}
</script>

<style scoped>

.avatar-uploader .el-upload {
  border: 1px #0c0404;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}
.avatar {
  width: 100px;
  height: 100px;
  display: block;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>