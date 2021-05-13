<template>
    <el-form
            :model="ruleForm"
            status-icon
            :rules="rules"
            ref="ruleForm"
            class="demo-ruleForm">
        <el-form-item prop="user">
            <el-input type="text" placeholder="请输入用户名" required="required" v-model="ruleForm.user"  prefix-icon="el-icon-user-solid"></el-input>
        </el-form-item>
        <el-form-item prop="phone">
            <el-input class="phone-input" placeholder="请输入手机号" v-model="ruleForm.phone" prefix-icon="el-icon-mobile-phone"></el-input>
        </el-form-item>
        <el-form-item prop="code" class="phone">
          <el-row>
            <el-col :span="16">
                <el-input v-model="ruleForm.code" placeholder="请输入验证码" :minlength="4" :maxlength="4"></el-input>
            </el-col>
            <el-col :span="8">
                <div @click="refreshCode">
                    <Sidentify :identifyCode="identifyCode"></Sidentify>
                </div>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item prop="pass">
            <el-input type="password" placeholder="请输入密码" v-model="ruleForm.pass" prefix-icon="el-icon-lock" show-password></el-input>
        </el-form-item>
        <el-form-item prop="checkPass">
            <el-input type="password" placeholder="请再次输入密码" v-model="ruleForm.checkPass"  prefix-icon="el-icon-lock"></el-input>
        </el-form-item>
        <el-form-item class="btn-form">
            <el-row type="flex" justify="center">
                <el-button type="primary"  @click="submitRegiForm('ruleForm')"   @keyup.enter.native="submitRegiForm('ruleForm')">注册</el-button>
            </el-row>
        </el-form-item>
    </el-form>
</template>

<script>
import Sidentify from "../Sidentify.vue";
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
        name: "Register",
        components:{
            Sidentify
        },
        data() {
            let validateUser1 = async (rule, value, callback) => {
                if (value === '') {
                     return callback(new Error('请输入用户名'))
                } else {
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
                    }else {
                      callback(new Error('号码格式错误'))
                      }
                    }
                }
            let validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'))
                } else {
                    if (this.ruleForm.checkPass !== '') {
                        this.$refs.ruleForm.validateField('checkPass')
                    }
                    callback()
                }
            }
            let validateCode = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入验证码'))
                } else {
                    if (value === this.identifyCode) {
                        console.log("验证码验证成功："+value)
                        callback()
                    } else {
                        callback(new Error('验证码错误'))
                    }
                }
            }
            let validatePass2 = (rule, value, callback) => {
                if (value !== this.ruleForm.pass && value !== '') {
                    callback(new Error('两次输入密码不一致!'))
                } else {
                    callback()
                }
            }
            return {
                identifyCodes:'1234567890abcdefghkmnrstvwxyz',
                identifyCode: '',
                ruleForm: {
                    user: '',
                    phone: '',
                    pass: '',
                    checkPass: '',
                    code: ''
                },
                rules: {
                    code: [{
                        required: true,
                        validator: validateCode,
                        trigger: 'blur'
                    }],
                    user: [{
                        required: true,
                        validator: validateUser1,
                        trigger: 'blur'
                    }],
                    phone: [{
                        required: true,
                        validator: validatePhone,
                        trigger: 'blur'
                    }],
                    // 密码
                    pass: [{
                        required: true,
                        validator: validatePass,
                        trigger: 'blur'
                    },
                        {
                            min: 6,
                            message: '长度请不少于6个字符',
                            trigger: 'blur'
                        }
                    ],
                    // 校验密码
                    checkPass: [{
                        required: true,
                        validator: validatePass2,
                        trigger: 'blur'
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
        mounted() {
            //生成验证码
            this.identifyCode = ''
            this.makeCode(this.identifyCodes, 4)
        },
        emits:['logdialogclosere'],
        methods:{
            randomNum(min, max) {
                return Math.floor(Math.random() * (max - min) + min)
            },
            //生成验证码
            makeCode(o, l) {
                for (let i = 0; i < l; i++) {
                    this.identifyCode += this.identifyCodes[
                        this.randomNum(0, this.identifyCodes.length)
                        ]
                }
                console.log(this.identifyCode)
            },
            refreshCode(){
                this.identifyCode = ''
                this.makeCode(this.identifyCodes, 4)
            },
            submitRegiForm(ruleForm)
            {
                this.$refs[ruleForm].validate((valid)=>{
                    if(valid){
                      request({url:"/user/register", method:"post" ,data:{
                        uname:this.ruleForm.user,
                        uphone: this.ruleForm.phone,
                        upassword:this.ruleForm.pass}
                      }).then(res=>{
                        if(res.data.code === 200)
                        {
                          this.$emit('logdialogclosere')
                          ElMessage.success({
                            message: '用户注册成功,请登录',
                            type: 'success'
                          });
                        }else {
                          ElMessage.error({
                            message:'注册失败:'+res.data.message,
                            duration:2000
                          });
                        }
                      }).catch(err=>{
                         ElMessage.error('发生以下错误:'+err);
                      })
                    }else {
                      return false;
                    }
                })
            }
        }

    }
</script>

<style scoped>

</style>