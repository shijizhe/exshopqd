<template>
  <el-dialog
      title="登录与注册"
      width="30%"
      v-model="dialogflag"
      :close-on-click-modal="false"
      :before-close="logdialogclose"
      :destroy-on-close="true"
      center
  >
    <el-tabs v-model="logflag" stretch>
      <el-tab-pane label="登陆" name="login">
        <login @logdialogcloseilo="logdialogcloselo"></login>
      </el-tab-pane>
      <el-tab-pane label="注册" name="register">
        <register @logdialogclosere="logdialogclosere"></register>
      </el-tab-pane>
    </el-tabs>
  </el-dialog>

</template>

<script>
import Login from "./Login.vue"
import Register from "./Register.vue";

export default {
  name: "Logdialog",
  data() {
    return {
    }
  },
  components: {
    Login,
    Register
  },
  props: {
    dialogflag: Boolean,
    logflag:String
  },
  emits: ['closedia','linktologin'],
  methods: {
    logdialogclose() {
      this.$emit('closedia')
    },
    logdialogcloselo() {
      this.$emit('closedia')
    },
    logdialogclosere() {
      this.$emit('linktologin')
    }

  }
}
</script>

<style scoped>

</style>