class Sample{
 		/**
        *Проверка гифа на анимацию
        *
        * @param {blob}, тело файла
        * @param {Function}, функция которая возвращает единственный параметр true - анимарованный, false - не анимированный
        */
        public static IsAnimatedGif(file: File, callback): void {
            'use strict'
            var reader = new FileReader();
            reader.onloadend = () => {
                var arr = new Uint8Array(reader.result),
                    i, len, length = arr.length, frames = 0;
			
                // make sure it's a gif (GIF8)
                if (arr[0] !== 0x47 || arr[1] !== 0x49 ||
                    arr[2] !== 0x46 || arr[3] !== 0x38) {
                    callback(false);
                    return;
                }		
                for (i = 0, len = length - 9; i < len; ++i) {
                    if (arr[i] === 0x00 && arr[i + 1] === 0x21 &&
                        arr[i + 2] === 0xF9 && arr[i + 3] === 0x04 &&
                        arr[i + 8] === 0x00 &&
                        (arr[i + 9] === 0x2C || arr[i + 9] === 0x21)) {
                        frames++;
                    }
                }
                console.log('в файле {0} количество кадров {1}'.format(file.name, frames.toString()));
                callback(frames > 1);
            };
            reader.readAsArrayBuffer(file);
        }
 }
 
 //Вспомогательный метод
 interface String
{
    format(...strings: string[]): string; 
}
   String.prototype.format = function () {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
                ? args[number]
                : match
                ;
        });
};
