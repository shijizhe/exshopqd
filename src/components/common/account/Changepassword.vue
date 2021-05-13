<template>
  <div style="padding: 30px;">
    <el-card class="box-card;" shadow="always" style="width: 40%">
      <template #header>
        <div class="card-header" style="text-align: left">
          <span>修改密码</span>
          <el-button class="button" type="text" @click="changPassword">更改</el-button>
        </div>
      </template>
      <el-form
          ref="passForm"
          :model="passForm"
          :rules="rules"
          status-icon
          style="padding-right: 30px;padding-left: 30px"
      >
        <el-form-item prop="pass1">
          <el-input type="password" v-model="passForm.pass1" placeholder="请输入原密码"  show-password></el-input>
        </el-form-item>
        <el-form-item prop="pass2">
          <el-input type="password" v-model="passForm.pass2" placeholder="请输入新密码"  show-password></el-input>
        </el-form-item>
      </el-form>
    </el-card>

  </div>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "Changepass",
  data() {
    let validatePass1 = async (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入原密码'))
      } else {
        await request({
          url: "/user/login", method: "get", params: {account: this.$store.state.user.uname, password: value}
        }).then(res => {
          if (res.data.code === 200) {
            callback()
          } else {
            callback(new Error('原密码错误'))
          }
        }).catch(err => {
          callback(new Error(err))
        })

      }
    }
    let validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入新密码'))
       }else if(value === this.passForm.pass1)
      {
        callback(new Error('不能与原密码相同'))
      }
      else {
        callback()
      }
    }
    return {
      passForm: {
        pass1: '',
        pass2: ''
      },
      rules: {
        pass1: [{
          required: true, validator: validatePass1, trigger: 'blur'
        }],
        pass2: [{
          required: true, validator: validatePass2, trigger: 'blur'
        },
          {
            min: 6,
            message: '长度请不少于6个字符',
            trigger: 'blur'
          }
        ]
      }
    }
  },
  methods: {
    changPassword() {
      this.$refs["passForm"].validate((valid) => {
        if (valid) {
          this.disabled = true
          request({url: '/user/changepass', method: 'get', params:{
                uid:this.$store.state.user.uid,
                upass:this.passForm.pass2
            }}).then(res => {
            if (res.data.code === 200) {
              ElMessage.success("更改用户信息成功")
              this.$refs["passForm"].resetFields();
            } else {
              ElMessage.info("更改用户信息失败,失败代码：" + res.data.code)
            }
          }).catch(err => {
            ElMessage.info("更改用户信息失败：" + err)
          })
        }
      })
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