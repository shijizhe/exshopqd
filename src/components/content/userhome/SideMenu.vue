<template>
  <div>
    <el-menu
        :uniqueOpened="true"
        :default-active="$route.path"
        router
        class="el-menu-vertical-demo"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
        style="padding-left: 10px"
    >

      <el-menu-item index="/">
        <template #title>商城首页</template>
      </el-menu-item>

      <el-menu-item index="/userhome/center">
        <template #title>个人信息</template>
      </el-menu-item>

      <el-menu-item index="/userhome/password">
        <template #title>修改密码</template>
      </el-menu-item>

      <el-menu-item index="/userhome/address">
        <template #title>收货地址</template>
      </el-menu-item>

      <el-menu-item index="/userhome/myorder">
        <template #title>我的订单</template>
      </el-menu-item>

      <el-menu-item index="/userhome/mycharity">
        <template #title>我的公益</template>
      </el-menu-item>

    </el-menu>
  </div>
</template>

<script>
export default {
  name: "SideMenu"
}
</script>

<style scoped>

</style>