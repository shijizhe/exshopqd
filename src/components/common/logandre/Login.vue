<template>
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
        <el-button type="text">忘记密码？
        </el-button>
      </el-form-item>
        <el-form-item>
            <el-row type="flex" justify="center">
                <el-button
                    type="primary"
                    @click="submitLoginForm('ruleForm')"
                    @keyup.enter.native="submitLoginForm('ruleForm')"
                >登录</el-button>
            </el-row>
        </el-form-item>
    </el-form>
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
                }else {
                  if(value)
                  {
                    await request({url:'/user/judgenameandphone', method:'get', params: {account:value}
                    }).then(response=>{
                      if(response.data.data === 'bothno')
                      {
                        callback(new Error('账户未注册'))
                      }else {
                        callback()
                      }
                    }).catch(err=>
                    {
                      callback(new Error(err))
                    })
                  }

                }
            }
            return {
                ruleForm: {
                    user: 'admin',
                    pass: '123456'
                },
                rules: {
                    user: [{ required: true, validator: validateUser, trigger: 'blur' }],
                    pass: [{ required: true, validator: validatePass, trigger: 'blur' }]
                }
            }
        },
        emits:['logdialogcloseilo'],
        methods:{
          submitLoginForm(ruleForm){
            this.$refs[ruleForm].validate((valid) => {
              if (valid) {
                request({url:"/user/login", method:"get" ,params:{account: this.ruleForm.user,password:this.ruleForm.pass}
                }).then(res=>{
                  if(res.data.code === 200)
                  {
                     this.$emit('logdialogcloseilo')
                     this.$store.commit("setStateLogin",res.data.data)
                     ElMessage.success({
                      message: '用户登陆成功!',
                      type: 'success'
                    });
                  }else {
                    ElMessage.error({
                      message:'密码错误,请重新尝试',
                      duration:2000
                    });
                    this.ruleForm.pass=''
                  }
                }).catch(err=>{
                   ElMessage.error('发生以下错误:'+err);
                })
              } else {
                return false;
              }
            });


          }
        }
    }
</script>

<style scoped>

</style>