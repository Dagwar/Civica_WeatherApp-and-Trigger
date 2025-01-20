import { LightningElement, track } from 'lwc';
import getWeather from '@salesforce/apex/CivicaWeatherAppController.getWeather';

export default class CivicaWeatherApp extends LightningElement {
    @track latitude = '';
    @track longitude = '';
    @track weatherData = null;
    @track errorMessage = '';

    // Update latitude
    handleLatitudeChange(event) {
        this.latitude = event.target.value;
    }

    // Update longitude
    handleLongitudeChange(event) {
        this.longitude = event.target.value;
    }

    // Fetch weather data
    async fetchWeatherData() {
        this.weatherData = null;
        this.errorMessage = '';

        if (!this.latitude || !this.longitude) {
            this.errorMessage = 'Please enter both latitude and longitude.';
            return;
        }

        try {
            const data = await getWeather({ latitude: this.latitude, longitude: this.longitude });
            this.weatherData = JSON.parse(data);
        } catch (error) {
            this.errorMessage = 'Failed to fetch weather data. Please try again.';
            console.error(error);
        }
    }
}
