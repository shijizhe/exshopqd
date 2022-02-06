<template>
  <div v-if="forgetpass">
    <el-card class="box-card;">
      <template #header>
        <el-page-header @back="goBack" content="忘记密码">
        </el-page-header>
      </template>
      <el-form
          :model="fpform"
          status-icon
          :rules="fprules"
          ref="fpform"
          class="demo-ruleForm">
        <el-form-item prop="uphone">
          <el-input placeholder="请输入手机号" v-model="fpform.uphone" prefix-icon="el-icon-mobile-phone"></el-input>
        </el-form-item>
        <el-form-item prop="upassword">
          <el-input placeholder="请输入重置密码" v-model="fpform.upassword" prefix-icon="el-icon-lock" type="password"></el-input>
        </el-form-item>
        <el-form-item>
          <div style="text-align: center">
            <el-button
                type="primary"
                @click="resetPassword('fpform')"
                @keyup.enter.native="resetPassword('fpform')"
            >重 置
            </el-button>
          </div>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
  <div v-else>
    <el-form
        :model="ruleForm"
        status-icon
        :rules="rules"
        ref="ruleForm"
        class="demo-ruleForm">
      <el-form-item prop="user">
        <el-input
            type="text"
            placeholder="请输入手机号或用户名"
            required="required"
            v-model="ruleForm.user"
            prefix-icon="el-icon-user-solid"
        ></el-input>
      </el-form-item>
      <el-form-item prop="pass">
        <el-input
            type="password"
            placeholder="请输入密码"
            prefix-icon="el-icon-lock"
            v-model="ruleForm.pass"
            show-password
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="forgetPassword" type="text">忘记密码？
        </el-button>
      </el-form-item>
      <el-form-item>
        <el-row type="flex" justify="center">
          <el-button
              type="primary"
              @click="submitLoginForm('ruleForm')"
              @keyup.enter.native="submitLoginForm('ruleForm')"
          >登录
          </el-button>
        </el-row>
      </el-form-item>
    </el-form>
  </div>

</template>

<script>

import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "Login",
  data() {
    let validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'))
      } else {
        callback()
      }
    }
    let validateUser = async (rule, value, callback) => {
      if (value === '') {
        callback(new Error('手机号或者用户名不能为空'))
      } else {
        if (value) {
          await request({
            url: '/user/judgenameandphone', method: 'get', params: {account: value}
          }).then(response => {
            if (response.data.data === 'bothno') {
              callback(new Error('账户未注册'))
            } else {
              callback()
            }
          }).catch(err => {
              callback(new Error(err))
          })
        }

      }
    }
    let validatePhone = async (rule, value, callback) => {
      if (value === '') {
        callback(new Error('手机号不能为空'))
      } else {
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
        }
        else {
          callback(new Error('号码格式错误'))
        }
      }
    }
    return {
      ruleForm: {
        user: 'admin',
        pass: '123456'
      },
      rules: {
        user: [{required: true, validator: validateUser, trigger: 'blur'}],
        pass: [{required: true, validator: validatePass, trigger: 'blur'}]
      },
      forgetpass: false,
      fpform: {
        uphone: '',
        upassword: ''
      },
      fprules:{
        uphone:[{required: true, validator: validatePhone, trigger: 'blur'}],
        upassword: [{required: true, validator: validatePass, trigger: 'blur'},
          {min: 6, message: '长度请不少于6个字符', trigger: 'blur'}]
      }
    }
  },
  emits: ['logdialogcloseilo'],
  methods: {
    submitLoginForm(ruleForm) {
      this.$refs[ruleForm].validate((valid) => {
        if (valid) {
          request({
            url: "/user/login", method: "get", params: {account: this.ruleForm.user, password: this.ruleForm.pass}
          }).then(res => {
            if (res.data.code === 200) {
              this.$emit('logdialogcloseilo')
              this.$store.commit("setStateLogin", res.data.data)
              ElMessage.success({
                message: '用户登陆成功!',
                type: 'success'
              });
            }
            else if(res.data.code ===420){
              ElMessage.warning("账号封禁中，无法登陆")
            }
            else {
              ElMessage.error({
                message: '密码错误,请重新尝试',
                duration: 2000
              });
              this.ruleForm.pass = ''
            }
          }).catch(err => {
            ElMessage.error('发生以下错误:' + err);
          })
        } else {
          return false;
        }
      });


    },
    forgetPassword() {
      this.forgetpass = true
    },
    goBack() {
      this.forgetpass = false
    },
    resetPassword(fpform) {
      request({url:'/user/resetpass',method:'get',params:{
        uphone:this.fpform.uphone,
        upass:this.fpform.upassword
      }}).then(res=>{
        if(res.data.code===200)
        {
           ElMessage.success("密码重置成功")
           this.goBack()
           this.$refs['fpform'].resetFields()
        }
      }).catch(err=>{
          ElMessage.error("发生以下错误："+err)
      })
    }
  }
}
</script>

<style scoped>

</style>