<template>
  <el-row :gutter="20" style="height: 200px;">
    <el-col :span="18">
      <el-carousel height="200px" direction="vertical">
        <el-carousel-item v-for="item in picItem" :key="item.id">
          <img :src="item.url" class="image" alt=""
               style="object-fit: fill;width: 100%;height: 100%">
        </el-carousel-item>
      </el-carousel>
    </el-col>
    <el-col :span="6">
      <div style="height:100%;">
        <el-table
            style="width: 100%;height: 100%;"
            max-height="400"
            class="eltable">
          <el-table-column
              prop="date"
              label="站内通知"
              width="180"
          >
          </el-table-column>
          <el-table-column
              prop="time"
              label=""
              width="40"
          >
          </el-table-column>
        </el-table>
      </div>
    </el-col>
  </el-row>
</template>

<script>
export default {
  name: "Carousel.vue",
  data(){
    return{
      picItem: [
        {
          id: 0,
          name: "a",
          url: require("../../../assets/image/gg/gga.png")
        },
        {
          id: 1,
          name: "b",
          url: require("../../../assets/image/gg/ggb.png")
        },
        {
          id: 2,
          name: "c",
          url: require("../../../assets/image/gg/ggc.png")
        },
        {
          id: 3,
          name: "d",
          url: require("../../../assets/image/gg/ggd.png")
        }
      ]
    }
  }
}
</script>

<style scoped>
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}
.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}
.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
.eltable {
  line-height: 20px;
}

</style>