<template>
  <div class="affix-container">
    <el-affix target=".affix-container" :offset="125">
      <el-menu
          :uniqueOpened="true"
          default-active="1"
          class="el-menu-vertical-demo"
          background-color="#545c64"
          text-color="#fff"
          active-text-color="#ffd04b"
          style="padding-left: 10px"
          @select="handleSelect"
      >

        <el-submenu
            v-for="item in menuData"
            :index="item.caId.toString()"
            :key="item.caId"
        >
          <template #title>
            <i :class="item.caIcon"></i>
            <span>{{ item.caName }}</span>
          </template>

          <el-menu-item
              v-for="subItem in item.children"
              :index="subItem.caId.toString()"
              :key="subItem.caId"
          >
            {{ subItem.caName }}
          </el-menu-item>

        </el-submenu>

      </el-menu>
    </el-affix>
  </div>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "SideMenu",
  data(){
     return{
       menuData:[]
     }
  },
  created() {
    this.getMenu()
  },
  emits:['categoryChange'],
  methods:{
      getMenu(){
        request({url: '/category/tree', method: 'get'}).then(res => {
          this.menuData = res.data.data;
        }).catch(
            err => {
              ElMessage.info("加载商品目录菜单错误：" + err)
            }
        )
      },
     handleSelect(index){
       this.$emit('categoryChange',index)

     }
  }
}
</script>

<style scoped>

</style>