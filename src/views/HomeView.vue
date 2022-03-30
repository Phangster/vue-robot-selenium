<template>
  <div v-if="!userStore.getters.isLoggedIn" class="d-grid gap-2 col-6 mx-auto">
    <FormLogin />
  </div>
  <div v-else class="text-center">
    <h2 id="title">Welcome Page, {{ userStore.state.name }}</h2>
    <div>
      <a href="https://www.wikipedia.org/">Wikipedia link</a>
    </div>
    <div class="qrcode">
      <img id="reader" class="my-image" :src="`data:image/png;base64,${testQR}`" alt="test"/>
    </div>
    <div>
      <iframe
        id="iframe"
        title="This is a unique title"
        src="sample.html"
      />
    </div>
    <div>
      <button id="file_download" class="btn btn-secondary" @click="download">
        download
      </button>
    </div>
    <button id="logout" class="btn btn-secondary" @click="logout">
      Logout
    </button>
  </div>
</template>

<script lang="ts">
import {
  defineComponent, onMounted, computed, ref,
} from 'vue';
import userStore from '@/stores/user';
import FormLogin from '@/components/FormLogin.vue';
import FileSaver from 'file-saver';
import { imgSrcToBlob, blobToBase64String } from 'blob-util';

export default defineComponent({
  name: 'App',
  components: { FormLogin },
  setup() {
    // eslint-disable-next-line global-require
    const qrImage = computed(() => require('@/assets/test_qr.png'));
    const testQR = ref();
    onMounted(() => {
      // eslint-disable-next-line no-unused-expressions
      userStore.getUser;
      imgSrcToBlob(qrImage.value).then((blob) => {
        blobToBase64String(blob).then((base64String) => {
          testQR.value = base64String;
        }).catch((err) => {
          console.log(err);
        });
      }).catch((err) => {
        console.log(err);
      });
    });

    const logout = () => {
      userStore.logout();
      console.log('logging out');
      console.log(userStore.state);
    };

    const download = () => {
      console.log('downloading');
      const blob = new Blob(['Hello, world!'], { type: 'text/plain;charset=utf-8' });
      FileSaver.saveAs(blob, 'hello world.txt');
    };
    return {
      userStore, logout, download, qrImage, testQR,
    };
  },
});
</script>
<style lang="css" scoped>
.my-image {
  width: 200px;
  height: 200px;
}
</style>
